<?php

class TB_FormHelper
{
    public static function initFlatVars(array $vars, $form_scope, $model_settings, $request_vars)
    {
        $result = array();
        foreach ($vars as $key => $value) {
            if (isset($request_vars[$form_scope][$key])) {
                $result[$key] = $request_vars[$form_scope][$key];
            } else {
                if (isset($model_settings[$form_scope][$key])) {
                    $result[$key] = $model_settings[$form_scope][$key];
                } else {
                    $result[$key] = $value;
                }
            }
        }

        return array($form_scope => $result);
    }

    public static function initFlatVarsSimple(array $default_vars, array $primary_vars, array $secondary_vars = array())
    {
        $result = array();
        foreach ($default_vars as $key => $value) {
            if (isset($primary_vars[$key])) {
                $result[$key] = $primary_vars[$key];
            } else
            if ($secondary_vars && isset($secondary_vars[$key])) {
                $result[$key] = $secondary_vars[$key];
            } else {
                $result[$key] = $value;
            }
        }

        return $result;
    }

    public static function initLangVars(array $vars, $form_scope, $model_settings, $request_vars, $languages)
    {
        $result = array();
        foreach ($languages as $language) {
            $lid = $language['language_id'];
            foreach ($vars as $key => $value) {
                if (isset($request_vars[$form_scope][$lid][$key])) {
                    $result[$lid][$key] = $request_vars[$form_scope][$lid][$key];
                } else {
                    if (isset($model_settings[$form_scope][$lid][$key])) {
                        $result[$lid][$key] = $model_settings[$form_scope][$lid][$key];
                    } else {
                        $result[$lid][$key] = $value;
                    }
                }
            }
        }

        return array($form_scope => $result);
    }

    public static function initLangVarsSimple(array $default_vars, array $model_vars, array $languages, array $request_vars = array())
    {
        $result = array();
        foreach ($languages as $language) {
            $lid = $language['language_id'];
            if (!isset($result[$lid])) {
                $result[$lid] = array();
            }
            foreach ($default_vars as $key => $value) {
                if ($request_vars && isset($request_vars[$lid][$key])) {
                    $result[$lid][$key] = $request_vars[$lid][$key];
                } else
                if (isset($model_vars[$lid][$key])) {
                    $result[$lid][$key] = $model_vars[$lid][$key];
                } else {
                    $result[$lid][$key] = $value;
                }
            }
        }

        return $result;
    }

    public static function transformLangVar($data, $key, $model_settings, $languages)
    {
        $result = array();
        list($var_name, $default_value) = each($data);
        foreach ($languages as $language) {
            $lid = $language['language_id'];
            if (isset($model_settings[$key][$var_name][$lid])) {
                $result[$lid] = $model_settings[$key][$var_name][$lid];
            } else {
                $result[$lid] = $default_value;
            }
        }

        return $result;
    }

    public static function transformLangVars($data, $key, $model_settings, $languages)
    {
        foreach ($data as $index => $item) {
            $transformed = self::transformLangVar(array($index => $item), $key, $model_settings, $languages);
            $result[$index] = self::transformLangVar(array($index, $item), $key, $model_settings, $languages);
        }

        return $result;
    }
}