<?php

class FireSlider_Admin_DefaultController extends TB_AdminController
{
    /**
     * @var TB_SettingsModel
     */
    protected $sliderSettingsModel;

    public function init()
    {
        $this->sliderSettingsModel = $this->manager->getTbSettingsModelInstance('slider', 0);
    }

    public function index()
    {
        $this->data['sliders'] = $this->sliderSettingsModel->getValues();

        $this->renderTemplate('index');
    }

    public function editSlider()
    {
        $slider = array();
        $action = 'add';
        if (isset($this->request->get['slider_id'])) {
            $slider = $this->sliderSettingsModel->getScopeSettings($this->request->get['slider_id']);
            $action = 'edit';
        }

        $this->getModel()->initSlider($slider);

        if ($action == 'edit') {
            $this->getModel()->filterSliderForView($slider);
        }

        $this->data['action'] = $action;
        $this->data['slider'] = $slider;

        $this->renderTemplate('edit_slider');
    }

    public function duplicateSlider()
    {
        if (!isset($this->request->get['slider_id']) || empty($this->request->get['slider_id']) || !$this->validate()) {
            return $this->sendJsonError('The slider cannot be duplicated!');
        }

        $slider = $this->sliderSettingsModel->getScopeSettings($this->request->get['slider_id']);
        $this->getModel()->initSlider($slider);

        $id = TB_Utils::genRandomString();
        $slider['id'] = $id;
        $slider['name'] = 'Duplicated ' . $slider['name'];

        $this->sliderSettingsModel->setAndPersistScopeSettings('slider_' . $id, $slider);

        return $this->sendJsonSuccess('The slider has been copied');
    }

    public function saveSlider()
    {
        if ($this->request->server['REQUEST_METHOD'] != 'POST' || !$this->validate()) {
            return $this->sendJsonError('You do not have sufficient permissions to modify this module!');
        }

        if (!isset($this->request->post['slider']) || empty($this->request->post['slider'])) {
            return $this->sendJsonError('Empty data!');
        }

        $form_data = $this->request->post['slider'];

        $this->getModel()->initSlider($form_data);
        $this->getModel()->persistSlider($form_data);

        $this->manager->wipeVarsCache('*.fireslider_' . $form_data['id'] . '.*');
        $this->manager->wipeStylesCache('pavilion.*');

        return $this->sendJsonSuccess('The slider has been saved');
    }

    public function deleteSlider()
    {
        if (!$this->validate()) {
            return $this->sendJsonError('You do not have sufficient permissions to modify this module!');
        }

        if (!isset($this->request->get['slider_id']) || empty($this->request->get['slider_id'])) {
            return $this->sendJsonError('The slider cannot be deleted!');
        }

        $this->sliderSettingsModel->deleteScopeSettings((string) $this->request->get['slider_id']);

        return $this->sendJsonSuccess('The slider has been deleted!');
    }

    public function checkPermissions()
    {
        if (!$this->validate()) {
            return $this->sendJsonError('You do not have sufficient permissions to modify this module!');
        }

        return $this->sendJsonSuccess('Success');
    }
}