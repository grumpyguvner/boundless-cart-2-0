<?php

final class TB_StaticThemeManager
{
    /**
     * @var TB_ThemeManager
     */
    private static $manager;

    public static function set(TB_ThemeManager $manager)
    {
        self::$manager = $manager;
    }

    /**
     * @return TB_ThemeManager
     * @throws Exception
     */
    public static function get()
    {
        if (null === self::$manager) {
            throw new Exception('There is no theme manager instance');
        }

        return self::$manager;
    }

    public static function has()
    {
        return null !== self::$manager;
    }
}