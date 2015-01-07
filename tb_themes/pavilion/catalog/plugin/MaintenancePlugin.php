<?php

class Theme_Catalog_MaintenancePlugin extends TB_ExtensionPlugin
{
    protected $init_order = 0;
    protected $is_maintenance;

    public function configure(TB_ViewDataBag $themeData)
    {
        $this->eventDispatcher->connect('core:beforeRouting', array($this, 'checkMaintenance'));
    }

    public function checkMaintenance(sfEvent $event)
    {
        $this->bootstrap();
        if ($this->is_maintenance) {
            $event->setReturnValue('common/maintenance');
            $event->setProcessed(true);
        }
    }

    public function execute(TB_ViewDataBag $themeData, Request $request)
    {
        $action = new Action('common/maintenance');

        if ($this->manager->gteOc2()) {
            $result = $action->execute($this->manager->getOcRegistry());
        } else {
            require_once tb_modification($action->getFile());

            $class = $action->getClass();
            $controller = new $class($this->manager->getOcRegistry());
            $result = call_user_func(array($controller, 'index'));
        }

        $this->is_maintenance = is_object($result) && get_class($result) == 'Action';
    }
}