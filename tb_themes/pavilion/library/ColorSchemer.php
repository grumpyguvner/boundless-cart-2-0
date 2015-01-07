<?php

class TB_ColorSchemer
{
    protected $widget_default_colors = array();
    protected $row_default_colors    = array();
    protected $area_default_colors   = array();
    protected $theme_default_colors  = array();
    protected $filtered              = array();

    protected $current_area = '';

    /**
     * @return TB_ColorSchemer
     */
    public static function getInstance()
    {
        static $instance = null;

        if (null === $instance) {
            $instance = new self();
        }

        return $instance;
    }

    public function setFilteredColors($colors, $context)
    {
        if (!isset($this->{$context . '_default_colors'})) {
            throw new Exception('Invalid color section');
        }

        $this->{$context . '_default_colors'} = $colors;
        array_push($this->filtered, $context);
    }

    public function filterThemeColors(array &$colors, array $default_colors)
    {
        $colors =  $this->filterColors($colors, $default_colors, 'theme');

        return $this;
    }

    public function filterAreaColors(array &$colors, array $default_colors, $area_name)
    {
        $this->current_area = $area_name;
        $colors =  $this->filterColors($colors, $default_colors, 'area');

        return $this;
    }

    public function filterRowColors(array &$colors, array $default_colors)
    {
        $colors = $this->filterColors($colors, $default_colors, 'row');

        return $this;
    }

    public function filterWidgetColors(array &$colors, array $default_colors)
    {
        $colors =  $this->filterColors($colors, $default_colors, 'widget');

        return $this;
    }

    protected function filterColors(array $colors, array $default_colors, $context)
    {
        foreach ($default_colors as $group_key => &$group_values) {
            foreach ($group_values as $section_key => &$section_values) {

                if (0 === strpos($section_key, '_')) {
                    continue;
                }

                if (isset($colors[$group_key][$section_key])) {
                    unset($colors[$group_key][$section_key]['elements']);
                    unset($colors[$group_key][$section_key]['important']);
                    unset($colors[$group_key][$section_key]['property']);
                    unset($colors[$group_key][$section_key]['force_print']);
                    unset($colors[$group_key][$section_key]['can_inherit']);
                    unset($colors[$group_key][$section_key]['inherit_key']);

                    $section_values = TB_FormHelper::initFlatVarsSimple($section_values, $colors[$group_key][$section_key]);
                }

                $section_values['id'] = $context . '_' . $group_key . '_' . $section_key;

                if (!isset($section_values['can_inherit']) || !$section_values['can_inherit']) {
                    continue;
                }

                if (empty($section_values['inherit_key'])) {
                    throw new Exception("Empty inherit key for {$group_key}[{$section_key}]");
                }

                if (false === strpos($section_values['inherit_key'], '.')) {
                    throw new Exception("Wrong inherit key {$section_values['inherit_key']} for {$group_key}[{$section_key}]");
                }

                $inherit_parent = $context;
                $inherit_key    = $section_values['inherit_key'];

                if (false !== strpos($inherit_key, ':')) {
                    list ($inherit_parent, $inherit_key) = explode(':', $section_values['inherit_key']);
                    if (!in_array($inherit_parent, $this->filtered)) {
                        var_dump($section_values);
                        throw new Exception("The '{$context}' color '{$inherit_key}' inherits from '{$inherit_parent}' which has not been processed yet.");
                    }
                }

                if (false === strpos($inherit_key, '.') || count(explode('.', $inherit_key)) > 2) {
                    throw new Exception('Invalid ' . $context . ' inherit key ' . $inherit_key);
                }

                $parent_default_colors = $inherit_parent != $context ? $this->{$inherit_parent . '_default_colors'} : $default_colors;

                list ($inherit_group, $inherit_section) = explode('.', $inherit_key);

                if (!isset($parent_default_colors[$inherit_group][$inherit_section])) {
                    $msg = "The parent of the current $context settings, defined by {$group_key}[{$section_key}][{$inherit_key}] does not exist.";
                    if (!empty($this->current_area)) {
                        $msg .= " Current area: " . $this->current_area;
                    }
                    throw new Exception($msg);
                }

                $section_values['parent_id']    = '';
                $section_values['parent_color'] = '';
                $inherit_parent_title           = 'Colors';

                if ($inherit_parent == $context) {
                    if (!isset($default_colors[$inherit_group][$inherit_section]['children'])) {
                        $default_colors[$inherit_group][$inherit_section]['children'] = array();
                    }
                    $default_colors[$inherit_group][$inherit_section]['children'][] = $section_values['id'];
                    $section_values['parent_id'] = $inherit_parent . '_' . $inherit_group . '_' . $inherit_section;
                    if ($section_values['inherit']) {
                        $section_values['color'] = $inherit_key;
                    }
                } else {
                    $section_values['parent_color'] = $parent_default_colors[$inherit_group][$inherit_section]['color'];
                    if ($section_values['inherit']) {
                        $section_values['color'] = $section_values['parent_color'];
                    }

                    switch ($inherit_parent) {
                        case 'theme':
                            $inherit_parent_title = 'Theme Colors';
                            if ($context == 'area') {
                                $section_values['parent_id'] = $inherit_parent . '_' . $inherit_group . '_' . $inherit_section;
                                unset($section_values['parent_color']);
                            }
                            break;
                        case 'area':
                            list(, $area_name) = explode('_', $this->current_area, 2);
                            $inherit_parent_title = ucfirst(str_replace('_', ' ', $area_name)) . ' Area -> Colors';
                            break;
                        case 'row':
                            $inherit_parent_title = 'Row -> Colors';
                            break;
                    }
                }

                $section_values['inherit_title'] = 'Unknown inherit';

                if (isset($parent_default_colors[$inherit_group]['_label'])) {
                    $section_values['inherit_title'] = 'Inherits from   ' .
                        $inherit_parent_title . ' - > ' .
                        $parent_default_colors[$inherit_group]['_label'] . ' -> ' .
                        $parent_default_colors[$inherit_group][$inherit_section]['label'];
                }

                array_push($this->filtered, $inherit_parent);
            }
        }

        foreach ($default_colors as &$group_values) {
            foreach ($group_values as $section_key => &$section_values) {
                if (0 === strpos($section_key, '_')) {
                    continue;
                }
                if (false !== strpos($section_values['color'], '.')) {
                    $section_values['color'] = $this->resolveParentColor($default_colors, $section_values['color']);
                }
            }
        }

        $colors = $this->{$context . '_default_colors'} = $default_colors;

        return $colors;
    }

    protected function resolveParentColor($colors, $inherit_key)
    {
        list ($inherit_group, $inherit_section) = explode('.', $inherit_key);

        if (!isset($colors[$inherit_group][$inherit_section])) {
            throw new Exception('The parent defined by ' . $inherit_key . ' does not exist');
        }

        $parent = $colors[$inherit_group][$inherit_section];

        if (false !== strpos($parent['color'], '.')) {
            if ($parent['color'] == $inherit_key) {
                throw new Exception('Infinite recursion detected when trying to resolve the color, defined by inherit key ' . $inherit_key);
            }

            return $this->resolveParentColor($colors, $parent['color']);
        }

        return $parent['color'];
    }
}