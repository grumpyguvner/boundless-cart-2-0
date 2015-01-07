<?php

class TB_Utils
{
    public static function parseDebug($debug)
    {
        if (!is_bool($debug)) {
            $ips = explode(',', $debug);
            $debug = false;
            foreach ($ips as $ip) {
                if ($ip == TB_Utils::getIp()) {
                    $debug = true;
                    break;
                }
            }
        }

        return $debug;
    }

    public static function getHost($remove_port = false)
    {
        $host = '';

        if (isset($_SERVER['HTTP_X_FORWARDED_HOST']) && ($host = $_SERVER['HTTP_X_FORWARDED_HOST'])) {
            $elements = explode(',', $host);
            $host = trim(end($elements));
        } else
        if (isset($_SERVER['HTTP_HOST']) && (!$host = $_SERVER['HTTP_HOST'])) {
            if (isset($_SERVER['SERVER_NAME']) && (!$host = $_SERVER['SERVER_NAME'])) {
                $host = !empty($_SERVER['SERVER_ADDR']) ? $_SERVER['SERVER_ADDR'] : '';
            }
        }

        if ($remove_port) {
            $host = preg_replace('/:\d+$/', '', $host);
        }

        return trim($host);
    }

    public static function getIp()
    {
        foreach (array('HTTP_CLIENT_IP', 'HTTP_X_FORWARDED_FOR', 'HTTP_X_FORWARDED', 'HTTP_X_CLUSTER_CLIENT_IP', 'HTTP_FORWARDED_FOR', 'HTTP_FORWARDED', 'REMOTE_ADDR') as $key) {
            if (array_key_exists($key, $_SERVER)) {
                foreach (explode(',', $_SERVER[$key]) as $ip) {
                    $ip = trim($ip);
                    if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4 | FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE) !== false) {
                        return $ip;
                    }
                }
            }
        }

        return isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : false;
    }

    public static function removeQueryStringVar($url, $key)
    {
        $url = preg_replace('/(.*)(\?|&)' . $key . '=[^&]+?(&)(.*)/i', '$1$2$4', $url . '&');
        $url = substr($url, 0, -1);

        return $url;
    }


    public static function glueUrl($parsed)
    {
        if (!is_array($parsed)) {
            return false;
        }

        $uri = isset($parsed['scheme']) ? $parsed['scheme'].':'.((strtolower($parsed['scheme']) == 'mailto') ? '' : '//') : '';
        $uri .= isset($parsed['user']) ? $parsed['user'].(isset($parsed['pass']) ? ':'.$parsed['pass'] : '').'@' : '';
        $uri .= isset($parsed['host']) ? $parsed['host'] : '';
        $uri .= isset($parsed['port']) ? ':'.$parsed['port'] : '';

        if (isset($parsed['path'])) {
            $uri .= (substr($parsed['path'], 0, 1) == '/') ?
                $parsed['path'] : ((!empty($uri) ? '/' : '' ) . $parsed['path']);
        }

        $uri .= isset($parsed['query']) ? '?'.$parsed['query'] : '';
        $uri .= isset($parsed['fragment']) ? '#'.$parsed['fragment'] : '';

        return $uri;
    }

    public static function addHttp($url)
    {
        if (!preg_match("~^(?:f|ht)tps?://~i", $url)) {
            $url = "http://" . $url;
        }

        return $url;
    }

    public static function modifyBase($base, $url, $force_ssl = false)
    {
        $base_parsed = parse_url($base);
        $base_host = $base_parsed['host'];

        if ('http' == $base_parsed['scheme'] && $force_ssl) {
            $base_parsed['scheme'] = 'https';
        }
        if (empty($base_parsed['scheme']) || !in_array($base_parsed['scheme'], array('http', 'https'))) {
            $base_parsed['scheme'] = $force_ssl ? 'https' : 'http';
        }

        $url_parsed = parse_url($base_parsed['scheme'] . '://' . $url);
        $url_host = $url_parsed['host'];

        if (stripos($url_host, $base_host) !== 0) {
            if (substr($url_host, 0, 4) == 'www.') {
                $base_host = 'www.' . $base_host;
            } else
                if (substr($base_host, 0, 4) == 'www.') {
                    $base_host = substr($base_host, 4);
                }
        }
        $base_parsed['host'] = $base_host;

        return self::glueUrl($base_parsed);
    }

    public static function compareUrlHostsEqual($url1, $url2)
    {
        if (substr($url1, 0, 4) != 'http') {
            $url1 = 'http://' . $url1;
        }

        if (substr($url2, 0, 4) != 'http') {
            $url2 = 'http://' . $url2;
        }

        $url1_parsed = parse_url($url1);
        $url2_parsed = parse_url($url2);

        $host1 = substr($url1_parsed['host'], 0, 4) == 'www.' ? substr($url1_parsed['host'], 4) : $url1_parsed['host'];
        $host2 = substr($url2_parsed['host'], 0, 4) == 'www.' ? substr($url2_parsed['host'], 4) : $url2_parsed['host'];

        return $host1 == $host2;
    }

    public static function genRandomString($length = 5)
    {
        $aZ09 = array_merge(range('A', 'Z'), range('a', 'z'), range(0, 9));
        shuffle($aZ09);
        $result ='';
        for($i = 0; $i < $length; $i++) {
           $result .= $aZ09[mt_rand(0, count($aZ09)-1)];
        }

        return str_shuffle($result);
    }

    public static function genRandomFloat($min, $max)
    {
       return ($min + lcg_value() * (abs($max - $min)));
    }

    public static function camelize($str)
    {
        return strtr(ucwords(strtr($str, array('_' => ' ', '.' => '_ '))), array(' ' => ''));
    }

    /**
     * Returns an underscore-syntaxed version or the CamelCased string.
     *
     * @param  string $camel_cased_word  String to underscore.
     *
     * @return string Underscored string.
     */
    public static function underscore($camel_cased_word)
    {
        $tmp = $camel_cased_word;
        $tmp = str_replace('::', '/', $tmp);
        $tmp = str_replace(' ', '_', $tmp);
        $tmp = self::pregtr($tmp, array('/([A-Z]+)([A-Z][a-z])/' => '\\1_\\2',
                                        '/([a-z\d])([A-Z])/'     => '\\1_\\2'));

        return strtolower($tmp);
    }

    public static function slugify($string)
    {
        return strtolower(trim(preg_replace('~[^0-9a-z]+~i', '-', html_entity_decode(preg_replace('~&([a-z]{1,2})(?:acute|cedil|circ|grave|lig|orn|ring|slash|th|tilde|uml);~i', '$1', htmlentities($string, ENT_QUOTES, 'UTF-8')), ENT_QUOTES, 'UTF-8')), '-'));
    }

    public static function hex2rgb($hex, $return_string = false)
    {
        $hex = str_replace('#', '', $hex);

        if(strlen($hex) == 3) {
            $r = hexdec(substr($hex,0,1).substr($hex,0,1));
            $g = hexdec(substr($hex,1,1).substr($hex,1,1));
            $b = hexdec(substr($hex,2,1).substr($hex,2,1));
        } else {
            $r = hexdec(substr($hex,0,2));
            $g = hexdec(substr($hex,2,2));
            $b = hexdec(substr($hex,4,2));
        }

        if (!$return_string) {
            return array($r, $g, $b);
        } else {
            return "$r,$g,$b";
        }
    }

    /**
     * Returns subject replaced with regular expression matches
     *
     * @param mixed $search        subject to search
     * @param array $replacePairs  array of search => replace pairs
     *
     * @return string
     */
    public static function pregtr($search, array $replacePairs)
    {
        return preg_replace(array_keys($replacePairs), array_values($replacePairs), $search);
    }

    public static function strStartsWith($haystack, $needle)
    {
        return (substr($haystack, 0, strlen($needle)) === $needle);
    }

    public static function strEndsWith($haystack, $needle)
    {
        $length = strlen($needle);
        if ($length == 0) {
            return true;
        }

        return (substr($haystack, -$length) === $needle);
    }

    public static function strGetBetween($content, $start, $end)
    {
        $r = explode($start, $content);
        if (isset($r[1])){
            $r = explode($end, $r[1]);

            return $r[0];
        }

        return '';
    }

    public static function strGetBefore($content, $end)
    {
        $r = explode($end, $content);

        return $r[0];
    }

    public static function strGetAfter($content, $start)
    {
        $r = explode($start, $content);
        if (isset($r[1])){
            return $r[1];
        }

        return '';
    }

    public static function minifyCss($css)
    {
        $find = array('!/\*.*?\*/!s',
            '/\n\s*\n/',
            '/[\n\r \t]/',
            '/ +/',
            '/ ?([,:;{}]) ?/',
            '/;}/'
        );
        $replace = array('',
            "\n",
            ' ',
            ' ',
            '$1',
            '}'
        );

        return preg_replace($find, $replace, $css);
    }

    public static function vqmodCheck($filename)
    {
        if (array_key_exists('vqmod', $GLOBALS)) {
            global $vqmod;

            if (is_callable(array($vqmod, 'modCheck'))) {
                if (!function_exists('modification')) {
                    return $vqmod->modCheck($filename);
                }

                return $vqmod->modCheck(modification($filename));
            }
        }

        if(class_exists('VQMod')) {
            if (!function_exists('modification')) {
                return VQMod::modCheck($filename);
            }

            return VQMod::modCheck(modification($filename));
        }

        return !function_exists('modification') ? $filename : modification($filename);
    }

    public static function removeJqueryFromHTML($html, $gteOc2)
    {
        if (false !== preg_match_all('/<script\b[^>]*>([\s\S]*?)(<\/script>)?/i', $html, $tag_matches)) {
            foreach ($tag_matches[0] as $tag) {
                if (false !== preg_match_all("/<script .*?(?=src)src=\"([^\"]+)\"/si", $tag, $src_matches)) {
                    foreach ($src_matches[1] as $src) {
                        $patterns = array('/jquery-.*\.js/i', '/tabs.js/i');
                        if ($gteOc2) {
                            $patterns = array_merge($patterns, array('/summernote.js/i', '/bootstrap-datetimepicker.min.js/i', '/moment.min.js/i', '/bootstrap.min.js/i', '/common.js/i'));
                        }
                        foreach ($patterns as $pattern) {
                            if (preg_match($pattern, basename($src))) {
                                $html = str_replace($tag, '', $html);
                            }
                        }
                    }
                }
            }
        }

        if (false !== preg_match_all('/<link\b[^>]*>([\s\S]*?)/i', $html, $tag_matches)) {
            foreach ($tag_matches[0] as $tag) {
                if (false !== preg_match_all("/<link .*?(?=href)href=\"([^\"]+)\"/si", $tag, $src_matches)) {
                    foreach ($src_matches[1] as $src) {
                        $patterns = array('/jquery-.*\.css/i');
                        if ($gteOc2) {
                            $patterns = array_merge($patterns, array('/summernote.css/i', '/bootstrap-datetimepicker.min.css/i'));
                        }
                        foreach ($patterns as $pattern) {
                            if (preg_match($pattern, basename($src))) {
                                $html = str_replace($tag, '', $html);
                            }
                        }
                    }
                }
            }
        }

        return $html;
    }

    public static function insertAfterBase($insert, $html)
    {
        if (preg_match('/<base\b[^>]*>([\s\S]*?)/i', $html, $tag_matches)) {
            $html = str_replace($tag_matches[0], $insert, $html);
        }

        return $html;
    }

    public static function objectToArray($data)
    {
        if (is_array($data) || is_object($data)) {
            $result = array();
            foreach ($data as $key => $value) {
                $result[$key] = self::objectToArray($value);
            }

            return $result;
        }

        return $data;
    }

    public static function randName($length = 5)
    {
        $vowels = array("a", "e", "o", "u");
        $consonants = array("b", "c", "d", "v", "g", "t");
        $result = '';

        for ($i = 0; $i < $length; $i++) {
            $result .= $vowels[array_rand($vowels, 1)];
            if ($i+1 < $length) {
                $result .= $consonants[array_rand($consonants, 1)];
                $i++;
            }
        }

        return ucfirst($result);
    }

    public static function getTbAppValue($key)
    {
        static $tbApp = null;

        if (null == $tbApp) {
            if (isset($_COOKIE['tbApp'])) {
                $tbApp = self::objectToArray(json_decode(base64_decode($_COOKIE['tbApp'])));
            } else {
                $tbApp = array();
            }
        }

        if (isset($tbApp[$key])) {
            return $tbApp[$key];
        }

        return null;
    }
}

class StopWatch {
    /**
     * @var $start float The start time of the StopWatch
     */
    private static $startTimes = array();

    /**
     * Start the timer
     *
     * @param $timerName string The name of the timer
     * @return void
     */
    public static function start($timerName = 'default')
    {
        self::$startTimes[$timerName] = microtime(true);
    }

    /**
     * Get the elapsed time in seconds
     *
     * @param $timerName string The name of the timer to start
     * @return float The elapsed time since start() was called
     */
    public static function elapsed($timerName = 'default')
    {
        return microtime(true) - self::$startTimes[$timerName];
    }
}

function tb_trim($str, $char_list = '')
{
    return trim($str, "\x00..\x1F" . $char_list);
}

if (!function_exists('tb_modification')) {
    function tb_modification($filename)
    {
        return TB_Utils::vqmodCheck($filename);
    }
}

if(!function_exists('array_replace_key')) {
    function array_replace_key(array &$array, $old_key, $new_key)
    {
        $keys = array_keys($array);
        if (false === $index = array_search($old_key, $keys)) {
            throw new Exception(sprintf('Key "%s" does not exit', $old_key));
        }
        $keys[$index] = $new_key;

        $array = array_combine($keys, array_values($array));
    }
}


if(!function_exists('array_remove_key')) {

    function array_remove_key(array &$array, $key)
    {
        if (isset($array[$key])) {
            $result = $array[$key];
            unset($array[$key]);

            return $result;
        }

        return $key;
    }

}

if (!function_exists('json_encode_safe')) {
    function json_encode_safe($str)
    {
        $json = json_encode($str);
        $search = array('\\',"\n","\r","\f","\t","\b","'") ;
        $replace = array('\\\\',"\\n", "\\r","\\f","\\t","\\b", "&#039");

        return str_replace($search,$replace,$json);
    }
}

if (!function_exists('shuffle_assoc')) {
    function shuffle_assoc($list) {
        if (!is_array($list)) {
            return $list;
        }

        $keys = array_keys($list);
        shuffle($keys);
        $random = array();
        foreach ($keys as $key) {
            $random[$key] = $list[$key];
        }

        return $random;
    }
}

if (!function_exists('array_merge_recursive_distinct')) {

    function array_merge_recursive_distinct() {
        $arrays = func_get_args();
        $base = array_shift($arrays);
        if(!is_array($base)) $base = empty($base) ? array() : array($base);
        foreach($arrays as $append) {
            if(!is_array($append)) $append = array($append);
            foreach($append as $key => $value) {
                if(!array_key_exists($key, $base) and !is_numeric($key)) {
                    $base[$key] = $append[$key];
                    continue;
                }
                if(isset($base[$key]) && (is_array($value) or is_array($base[$key]))) {
                    $base[$key] = array_merge_recursive_distinct($base[$key], $append[$key]);
                } else if(is_numeric($key)) {
                    if(!in_array($value, $base)) $base[] = $value;
                } else {
                    $base[$key] = $value;
                }
            }
        }
        return $base;
    }

}

if (!function_exists('array_replace')) {

  function array_replace(array $array)
  {
    $args = func_get_args();
    $count = func_num_args();

    for ($i = 0; $i < $count; ++$i) {
      if (is_array($args[$i])) {
        foreach ($args[$i] as $key => $val) {
          $array[$key] = $val;
        }
      } else {
        trigger_error(
          __FUNCTION__ . '(): Argument #' . ($i+1) . ' is not an array',
          E_USER_WARNING
        );

        return null;
      }
    }

    return $array;
  }

}

function array_replace_ref(array &$array1, array $array2)
{
    $array1 = array_replace($array1, $array2);
}

if (!function_exists('array_replace_recursive')) {

    function array_apply_recursion($array, $array1)
    {
        foreach ($array1 as $key => $value) {
            // create new key in $array, if it is empty or not an array
            if (!isset($array[$key]) || (isset($array[$key]) && !is_array($array[$key]))) {
                $array[$key] = array();
            }

            // overwrite the value in the base array
            if (is_array($value)) {
                $value = array_apply_recursion($array[$key], $value);
            }

            $array[$key] = $value;
        }

        return $array;
    }

    function array_replace_recursive()
    {
        $args = func_get_args();
        $count = func_num_args();
        $array = $args[0];

        for ($i = 1; $i < $count; $i++) {
            if (is_array($args[$i])) {
                $array = array_apply_recursion($array, $args[$i]);
            } else {
                trigger_error(
                    __FUNCTION__ . '(): Argument #' . ($i+1) . ' is not an array',
                    E_USER_WARNING
                );

                return null;
            }
        }

        return $array;
    }

}

if(!function_exists('lcfirst')) {

    function lcfirst($str)
    {
        $str[0] = strtolower($str[0]);

        return $str;
    }

}

if(!function_exists("date_create_from_format")) {

    function date_create_from_format($dformat, $dvalue)
    {
        $schedule = $dvalue;
        $schedule_format = str_replace(array('Y','m','d', 'H', 'i','a'),array('%Y','%m','%d', '%I', '%M', '%p' ) ,$dformat);
        // %Y, %m and %d correspond to date()'s Y m and d.
        // %I corresponds to H, %M to i and %p to a
        $ugly = strptime($schedule, $schedule_format);
        $ymd = sprintf(
            // This is a format string that takes six total decimal
            // arguments, then left-pads them with zeros to either
            // 4 or 2 characters, as needed
            '%04d-%02d-%02d %02d:%02d:%02d',
            $ugly['tm_year'] + 1900,  // This will be "111", so we need to add 1900.
            $ugly['tm_mon'] + 1,      // This will be the month minus one, so we add one.
            $ugly['tm_mday'],
            $ugly['tm_hour'],
            $ugly['tm_min'],
            $ugly['tm_sec']
        );

        return new DateTime($ymd);
    }
}

if (!function_exists('array_column')) {

    /**
     * Returns the values from a single column of the input array, identified by
     * the $columnKey.
     *
     * Optionally, you may provide an $indexKey to index the values in the returned
     * array by the values from the $indexKey column in the input array.
     *
     * @copyright Copyright (c) 2013 Ben Ramsey <http://benramsey.com>
     * @license http://opensource.org/licenses/MIT MIT*
     *
     * @param array $input A multi-dimensional array (record set) from which to pull
     *                     a column of values.
     * @param mixed $columnKey The column of values to return. This value may be the
     *                         integer key of the column you wish to retrieve, or it
     *                         may be the string key name for an associative array.
     * @param mixed $indexKey (Optional.) The column to use as the index/keys for
     *                        the returned array. This value may be the integer key
     *                        of the column, or it may be the string key name.
     * @return array
     */
    function array_column($input = null, $columnKey = null, $indexKey = null)
    {
        // Using func_get_args() in order to check for proper number of
        // parameters and trigger errors exactly as the built-in array_column()
        // does in PHP 5.5.
        $argc = func_num_args();
        $params = func_get_args();

        if ($argc < 2) {
            trigger_error("array_column() expects at least 2 parameters, {$argc} given", E_USER_WARNING);
            return null;
        }

        if (!is_array($params[0])) {
            trigger_error('array_column() expects parameter 1 to be array, ' . gettype($params[0]) . ' given', E_USER_WARNING);
            return null;
        }

        if (!is_int($params[1])
            && !is_float($params[1])
            && !is_string($params[1])
            && $params[1] !== null
            && !(is_object($params[1]) && method_exists($params[1], '__toString'))
        ) {
            trigger_error('array_column(): The column key should be either a string or an integer', E_USER_WARNING);
            return false;
        }

        if (isset($params[2])
            && !is_int($params[2])
            && !is_float($params[2])
            && !is_string($params[2])
            && !(is_object($params[2]) && method_exists($params[2], '__toString'))
        ) {
            trigger_error('array_column(): The index key should be either a string or an integer', E_USER_WARNING);
            return false;
        }

        $paramsInput = $params[0];
        $paramsColumnKey = ($params[1] !== null) ? (string) $params[1] : null;

        $paramsIndexKey = null;
        if (isset($params[2])) {
            if (is_float($params[2]) || is_int($params[2])) {
                $paramsIndexKey = (int) $params[2];
            } else {
                $paramsIndexKey = (string) $params[2];
            }
        }

        $resultArray = array();

        foreach ($paramsInput as $row) {

            $key = $value = null;
            $keySet = $valueSet = false;

            if ($paramsIndexKey !== null && array_key_exists($paramsIndexKey, $row)) {
                $keySet = true;
                $key = (string) $row[$paramsIndexKey];
            }

            if ($paramsColumnKey === null) {
                $valueSet = true;
                $value = $row;
            } elseif (is_array($row) && array_key_exists($paramsColumnKey, $row)) {
                $valueSet = true;
                $value = $row[$paramsColumnKey];
            }

            if ($valueSet) {
                if ($keySet) {
                    $resultArray[$key] = $value;
                } else {
                    $resultArray[] = $value;
                }
            }
        }

        return $resultArray;
    }

}

set_exception_handler('exceptionHandler');
function exceptionHandler(Exception $exception) {
    echo renderException($exception);
}

function renderException(Exception $exception)
{
    $msg = "PHP Fatal error: '<strong>%s</strong>' \n in %s:%s\nStack trace:\n";
    $msg = sprintf(
        $msg,
        $exception->getMessage(),
        $exception->getFile(),
        $exception->getLine()
    );

    $rootDir = realpath(DIR_SYSTEM . '/../') . '/';

    return nl2br($msg . str_replace($rootDir, '', $exception->getTraceAsString()));
}
