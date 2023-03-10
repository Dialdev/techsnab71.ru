<?php
##==================================================================##
## @author    : OCdevWizard                                         ##
## @contact   : ocdevwizard@gmail.com                               ##
## @support   : http://help.ocdevwizard.com                         ##
## @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf ##
## @copyright : (c) OCdevWizard. Setting, 2017                      ##
##==================================================================##
class ModelExtensionOcdevwizardOcdevwizardSetting extends Model {
	public function getSetting($code, $store_id = 0) {
		$setting_data = array();

		if ($this->checkTableExist(DB_PREFIX."ocdevwizard_setting")) {
			$query = $this->db->query("SELECT * FROM ".DB_PREFIX."ocdevwizard_setting WHERE store_id = '".(int)$store_id."' AND `code` = '".$this->db->escape($code)."'")->rows;

			foreach ($query as $result) {
				$setting_data[$result['key']] = (!$result['serialized']) ? $result['value'] : json_decode($result['value'], true);
			}
		}

		return $setting_data;
	}

	public function getSettingData($key, $store_id = 0) {
		$setting_data = array();

		if ($this->checkTableExist(DB_PREFIX."ocdevwizard_setting")) {
			$query = $this->db->query("SELECT * FROM ".DB_PREFIX."ocdevwizard_setting WHERE store_id = '".(int)$store_id."' AND `key` = '".$this->db->escape($key)."'")->rows;

			foreach ($query as $result) {
				$setting_data = (!$result['serialized']) ? $result['value'] : json_decode($result['value'], true);
			}
		}

		return $setting_data;
	}

	public function editSetting($code, $data, $store_id = 0) {
		$this->db->query("DELETE FROM ".DB_PREFIX."ocdevwizard_setting WHERE store_id = '".(int)$store_id."' AND `code` = '".$this->db->escape($code)."'");

		foreach ($data as $key => $value) {
			if (substr($key, 0, strlen($code)) == $code) {
				if (!is_array($value)) {
					$this->db->query("INSERT INTO ".DB_PREFIX."ocdevwizard_setting SET store_id = '".(int)$store_id."', `code` = '".$this->db->escape($code)."', `key` = '".$this->db->escape($key)."', `value` = '".$this->db->escape($value)."'");
				} else {
					$this->db->query("INSERT INTO ".DB_PREFIX."ocdevwizard_setting SET store_id = '".(int)$store_id."', `code` = '".$this->db->escape($code)."', `key` = '".$this->db->escape($key)."', `value` = '".$this->db->escape(json_encode($value))."', serialized = '1'");
				}
			}
		}
	}

	public function deleteSetting($code, $store_id = 0) {
		$this->db->query("DELETE FROM ".DB_PREFIX."ocdevwizard_setting WHERE store_id = '".(int)$store_id."' AND `code` = '".$this->db->escape($code)."'");
	}

	public function editSettingValue($code = '', $key = '', $value = '', $store_id = 0) {
		if (!is_array($value)) {
			$this->db->query("UPDATE ".DB_PREFIX."ocdevwizard_setting SET `value` = '".$this->db->escape($value)."', serialized = '0'  WHERE `code` = '".$this->db->escape($code)."' AND `key` = '".$this->db->escape($key)."' AND store_id = '".(int)$store_id."'");
		} else {
			$this->db->query("UPDATE ".DB_PREFIX."ocdevwizard_setting SET `value` = '".$this->db->escape(json_encode($value))."', serialized = '1' WHERE `code` = '".$this->db->escape($code)."' AND `key` = '".$this->db->escape($key)."' AND store_id = '".(int)$store_id."'");
		}
	}

	public function checkTableExist($table_name) {
    return $this->db->query("SELECT COUNT(*) as total FROM information_schema.TABLES WHERE TABLE_SCHEMA = '".DB_DATABASE."' AND TABLE_NAME = '".$table_name."'")->row['total'];
  }
}
