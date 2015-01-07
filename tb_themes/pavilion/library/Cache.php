<?php

class TB_Cache
{
    private $expire;
    protected $cache_dir;
    protected $prefix;

    public function __construct($cache_dir, $expire = 3600, $prefix = '', $probability = 25)
    {
        $this->cache_dir = $cache_dir;
        $this->expire    = $expire;
        $this->prefix    = !empty($prefix) ? $prefix . '.' : $prefix;

        $this->purgeExpired($probability);

        if (!is_dir($cache_dir)) {
            mkdir($cache_dir, 0777);
        }
    }

    public function get($key)
    {
        $files = glob($this->getPath($key) . '.*');

        if ($files && substr(strrchr($files[0], '.'), 1) > time()) {
            return unserialize(file_get_contents($files[0]));
        }

        return null;
    }

    public function set($key, $value, $expire = null, $keep_timestamp = false)
    {
        if (!is_dir($this->cache_dir)) {
            return;
        }

        if (null === $expire) {
            $expire = $this->expire;
        }

        if ($keep_timestamp && ($files = glob($this->getPath($key) . '.*')) && substr(strrchr($files[0], '.'), 1) > time()) {
            $file = $files[0];
        } else {
            $this->delete($key);
            $file = $this->getPath($key) . '.' . (time() + $expire);
        }

        $handle = fopen($file, 'w+');

        if (flock($handle, LOCK_EX | LOCK_NB)) {
            fwrite($handle, serialize($value));
        }

        flock($handle, LOCK_UN);
        fclose($handle);
    }

    public function delete($key = '')
    {
        $files = glob($this->getPath($key) . '.*');

        if ($files) {
            foreach ($files as $file) {
                unlink($file);
            }
        }
    }

    private function purgeExpired($probability)
    {
        if (rand(0,100) < $probability && $files = glob($this->cache_dir . '/cache.*')) {
            foreach ($files as $file) {
                if (substr(strrchr($file, '.'), 1) < time()) {
                    unlink($file);
                }
            }
        }
    }

    private function getPath($key)
    {
        return $this->cache_dir . '/cache.' . $this->prefix . preg_replace('/[^A-Z0-9\._-]/i', '', $key);
    }
}