<?php

class TB_DbSettingsHelper
{
    /**
     * @var TB_DbHelper
     */
    protected $dbHelper;

    /**
     * @var string
     */
    protected $settings_table;

    /**
     * @var DB
     */
    protected $db;

    protected $group_field_name = 'group';

    public function __construct(TB_DbHelper $dbHelper, $settings_table = 'setting')
    {
        $this->dbHelper = $dbHelper;
        $this->settings_table = $settings_table;
        $this->db = $dbHelper->getDb();
    }

    public function setGroupFieldName($name)
    {
        $this->group_field_name = $name;
    }

    /**
     * @param string $key
     * @param int $store_id
     * @param string $group
     *
     * @return null|mixed
     */
    public function getKey($key, $store_id, $group = '')
    {
        $sql = 'SELECT * FROM ' .
                $this->dbHelper->getDbPrefix() . $this->settings_table . '
                WHERE `store_id` = ' . (int) $store_id . ' AND
                      `key` = '      . $this->dbHelper->quote($key);
        if (!empty($group)) {
            $sql .= ' AND `' . $this->group_field_name . '` = '    . $this->dbHelper->quote($group);
        }

        $result = $this->db->query($sql);

        if ($result->num_rows > 0) {
            if ($result->row['serialized'] == '1') {
                return unserialize($result->row['value']);
            } else {
                return $result->row['value'];
            }
        }

        return null;
    }

    public function deleteKey($key, $store_id, $group = '')
    {
        $where = array(
            'store_id' => $store_id,
            'key'      => $key
        );
        if (!empty($group)) {
            $where[$this->group_field_name] = $group;
        }

        $this->dbHelper->deleteRecord($this->settings_table, $where);
    }

    public function persistKey($key, $store_id, $group, $value)
    {
        if (null !== $this->getKey($key, $store_id, $group)) {
            $data = array(
                'value'      => is_array($value) ? serialize($value) : $value,
                'serialized' => is_array($value) ? 1 : 0
            );
            $where = array(
                'store_id'              => $store_id,
                $this->group_field_name => $group,
                'key'                   => $key
            );
            $this->dbHelper->updateRecord($this->settings_table, $data, $where);
        } else {
            $data = array(
                'store_id'              => $store_id,
                $this->group_field_name => $group,
                'key'                   => $key,
                'value'                 => is_array($value) ? serialize($value) : $value,
                'serialized'            => is_array($value) ? 1 : 0
            );

            $this->dbHelper->addRecord($this->settings_table, $data);
        }
    }

    public function getKeys($store_id, $group = '')
    {
        $sql = 'SELECT setting_id, `key` FROM ' .
            $this->dbHelper->getDbPrefix() . $this->settings_table . '
                WHERE `store_id` = ' . (int) $store_id;
        if (!empty($group)) {
            $sql .= ' AND `' . $this->group_field_name . '` = ' . $this->dbHelper->quote($group);
        }

        return array_column($this->db->query($sql)->rows, 'key', 'setting_id');
    }

    public function getKeyCollection($keys, $store_id, $group = '')
    {
        $sql = 'SELECT `key`, value, serialized
                FROM ' . DB_PREFIX . 'tb_setting
                WHERE `store_id` = ' . $store_id . ' AND
                      `key` IN (\'' . implode("','", $keys) . '\')';

        if (!empty($group)) {
            $sql .= ' AND `' . $this->group_field_name . '` = ' . $this->dbHelper->quote($group);
        }

        $result = array();
        foreach ($this->db->query($sql)->rows as $row) {
            if ($row['serialized'] == '1') {
                $result[$row['key']] = unserialize($row['value']);
            } else {
                $result[$row['key']] = $row['value'];
            }
        }

        return $result;
    }

    public function getKeyStoreCollection($keys, $group)
    {
        $sql = 'SELECT `key`, value, serialized
                FROM ' . DB_PREFIX . 'tb_setting
                WHERE `' . $this->group_field_name . '` = ' . $this->dbHelper->quote($group);

        $sql_keys = array();
        foreach ($keys as $key => $store_id) {
            $sql_keys[] = '(`key` = "' . $key . '" AND `store_id` = ' . (int) $store_id . ')';
        }

        $sql .= ' AND ' . implode(' OR ', $sql_keys);

        $result = array();
        foreach ($this->db->query($sql)->rows as $row) {
            if ($row['serialized'] == '1') {
                $result[$row['key']] = unserialize($row['value']);
            } else {
                $result[$row['key']] = $row['value'];
            }
        }

        return $result;
    }

    public function getGroup($group, $store_id)
    {
        $sql = 'SELECT * FROM ' .
                $this->dbHelper->getDbPrefix() . $this->settings_table . '
                WHERE `store_id` = ' . (int) $store_id . ' AND
                      `' . $this->group_field_name . '` = ' . $this->dbHelper->quote($group);
        $result = $this->db->query($sql);

        $data = array();
        foreach ($result->rows as $row) {
            if ($row['serialized'] == '1') {
                $data[$row['key']] = unserialize($row['value']);
            } else {
                $data[$row['key']] = $row['value'];
            }
        }

        return $data;
    }

    public function persistGroup($group, $data, $store_id)
    {
        foreach ($data as $key => $value) {
            $this->persistKey($key, $store_id, $group, $value);
        }
    }
}