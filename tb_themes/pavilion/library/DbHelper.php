<?php
class TB_DbHelper
{
    /**
     * @var DB
     */
	protected $db;

    /**
     * @var string
     */
    protected $db_prefix;

    /**
     * @var string
     */
    protected $basename;

	public function __construct($db, $db_prefix = '', $basename)
    {
		$this->db = $db;
        $this->db_prefix = $db_prefix;
        $this->basename = $basename;
	}

    /**
     * @param string $table_name
     * @param array $data
     * @return string
     */
    public function addRecord($table_name, array $data)
    {
        $table_name = $this->db_prefix . $table_name;

        $fields = array_keys($data);
        $values = array_values($data);

        foreach ($fields as $key => $field) {
            $fields[$key] = '`' . $field . '`';
            $values[$key] = $this->quote($values[$key]);
        }

        $fieldList = implode(', ', $fields);
        $valueList = implode(', ', $values);

        $sql = "INSERT INTO `$table_name` ($fieldList) VALUES ($valueList)";

        return $this->db->query($sql);
    }

    public function addMultipleRecords($table_name, array $fields, array $data)
    {
        $table_name = $this->db_prefix . $table_name;
        $fields = '`' . implode('`,`', $fields) . '`';

        $sql_values = array();
        foreach($data as $row) {
            foreach ($row as &$row_value) {
                $row_value = $this->quote($row_value);
            }
            $sql_values[] = '(' . implode(',', $row) . ')';
        }
        $sql_values = implode(',', $sql_values);

        $sql = "INSERT INTO `$table_name` ($fields) VALUES $sql_values";

        return $this->db->query($sql);
    }

    /**
     * @param string $table_name
     * @param array $data
     * @param null|string $where
     * @return string
     */
    public function updateRecord($table_name, array $data, $where = null)
    {
        $table_name = $this->db_prefix . $table_name;

        $fields = array_keys($data);
        $values = array_values($data);
        $tmp    = array();

        foreach ($fields as $key => $field) {
            $tmp[] = '`' . $field . '` = ' . $this->quote($values[$key]);
        }
        $fieldList = implode(', ', $tmp);

        if (is_array($where)) {
            $where = $this->parseWhere($where);
        }

        $sql = "UPDATE `$table_name` SET $fieldList";
        if (!empty($where)) {
            $sql .= ' WHERE ' . $where;
        }

        return $this->db->query($sql);
    }

    /**
     * @param string $table_name
     * @param string|array $where
     * @return string
     */
    public function deleteRecord($table_name, $where)
    {
        if (empty($where)) {
            return false;
        }

        $table_name = $this->db_prefix . $table_name;

        if (is_array($where)) {
            $where = $this->parseWhere($where);
        }

        $sql = "DELETE FROM `$table_name` WHERE $where";

        return $this->db->query($sql);
    }

    /**
     * @param $table_name
     * @param $where
     * @return array|false
     */
    public function getRecords($table_name, $where)
    {
        $table_name = $this->db_prefix . $table_name;

        if (is_array($where)) {
            $where = $this->parseWhere($where);
        }

        $sql = "SELECT * FROM `$table_name` WHERE $where";
        if ($result = $this->db->query($sql)->rows) {
            return $result;
        }

        return false;
    }

    public function getRecord($table_name, $where)
    {
        if (empty($where)) {
            return false;
        }

        $records = $this->getRecords($table_name, $where);

        if ($records) {
            return $records[0];
        }

        return false;
    }

    public function getValue($table_name, $field, $where)
    {
        $record = $this->getRecord($table_name, $where);

        if (!isset($record[$field])) {
            return false;
        }

        return $record[$field];
    }

    public function getCount($table_name, $where = '')
    {
        $table_name = $this->db_prefix . $table_name;

        $sql = 'SELECT COUNT(*) AS cnt FROM `' . $table_name . '`';

        if (is_array($where)) {
            $where = $this->parseWhere($where);
        }

        if (!empty($where)) {
            $sql .= ' ' . $where;
        }

        if ($result = $this->db->query($sql)->row) {
            return (int) $result['cnt'];
        }

        return 0;
    }

    public function getColumn($table_name, $field, $where)
    {
        $records = $this->getRecords($table_name, $where);

        if (!$records || !isset($records[0][$field])) {
            return false;
        }

        $result = array();

        foreach ($records as $record) {
            $result[] = $record[$field];
        }

        return $result;
    }

    public function importSQL($sql_lines)
    {
        $sql_statement = '';

        foreach ((array) $sql_lines as $line) {

            if (substr($line, 0, 2) == '--' || $line == '') {
                continue;
            }

            $sql_statement .= $line;

            if (substr(trim($line), -1, 1) == ';') {
                $this->db->query($sql_statement);
                $sql_statement = '';
            }
        }
    }

    public function truncateTable($table)
    {
        foreach ((array) $table as $table_name) {
            $this->db->query('TRUNCATE TABLE `' . $this->db_prefix . $table_name . '`');
        }
    }

    public function dropTable($table)
    {
        foreach ((array) $table as $table_name) {
            $this->db->query('DROP TABLE IF EXISTS ' . $this->db_prefix . $table_name);
        }
    }

    public function getFoundRows()
    {
        return $this->db->query('SELECT FOUND_ROWS() AS cnt');
    }

    public function getLastId()
    {
        return $this->db->getLastId();
    }

    public function countAffected()
    {
        return $this->db->countAffected();
    }

    public function quote($string)
    {
        return "'" . $this->db->escape($string) . "'";
    }

    public function getDb()
    {
        return $this->db;
    }

    public function getDbPrefix()
    {
        return $this->db_prefix;
    }

    public function getBaseName()
    {
        return $this->basename;
    }

    protected function parseWhere(array $where)
    {
        $fields = array_keys($where);
        $values = array_values($where);
        $tmp    = array();

        foreach ($fields as $key => $field) {
            $tmp[] = '`' . $field . '` = ' . $this->quote($values[$key]);
        }

        return implode(' AND ', $tmp);
    }
}