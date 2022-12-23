<?php
##==================================================================##
## @author    : OCdevWizard                                         ##
## @contact   : ocdevwizard@gmail.com                               ##
## @support   : http://help.ocdevwizard.com                         ##
## @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf ##
## @copyright : (c) OCdevWizard. Smart Contact Us Pro, 2017         ##
##==================================================================##
class ControllerExtensionOcdevwizardSmartContactUsProStatic extends Controller {
  private $_name = 'smart_contact_us_pro';
  private $_code = 'smcup';
  private $_version = '1.0.1';
  
  public function index($setting) {
    $data = array();
    
    $models = array(
      'catalog/information',
      'extension/ocdevwizard/'.$this->_name
    );
    
    foreach ($models as $model) {
      $this->load->model($model);
    }
    
    $data = array_merge($data, $this->language->load('extension/ocdevwizard/'.$this->_name), $setting);
    
    $language_id = $this->{'model_extension_ocdevwizard_'.$this->_name}->getLanguageByCode($this->session->data['language']);
    
    $data['heading_title'] = $setting['heading'];
    $data['button_save']   = $setting['save_button'];
    $data['form_id']       = $form_id = $setting['form_id'];
    $data['text_info']     = html_entity_decode($setting['info_message'], ENT_QUOTES, 'UTF-8');
    
    $data['_name']          = $this->_name;
    $data['_code']          = $this->_code;
    $data['_language_code'] = substr($this->session->data['language'], 0, 2);
    
    $data['fields_data'] = array();
    
    if ($setting && $setting['display_type'] == 2) {
      foreach ($this->getActiveField($form_id) as $field) {
        
        switch ($field['position']) {
          case '1':
            $position = "left";
            break;
          case '2':
            $position = "right";
            break;
          case '3':
            $position = "center";
            break;
        }
        
        $view_fields = array();
        
        if (!empty($field['view_fields'])) {
          $view_fields = explode(";", $field['view_fields'][$language_id]);
        }
        
        $data['fields_data'][] = array(
          'activate'    => $field['activate'],
          'title'       => $field['title'][$language_id],
          'name'        => $field['name'],
          'type'        => $field['view'],
          'view_fields' => $view_fields,
          'check'       => $field['check'],
          'mask'        => $field['mask'],
          'error_text'  => $field['error_text'],
          'css_id'      => $field['css_id'],
          'css_class'   => $field['css_class'],
          'position'    => $position
        );
      }
    }
    
    $data['informations'] = array();
    
    if (isset($setting['require_information']) && $setting['require_information']) {
      $informations         = $this->model_catalog_information->getInformation((int)$setting['require_information']);
      $data['informations'] = sprintf($this->language->get('text_require_information'), $this->url->link('information/information', 'information_id='.$setting['require_information']), $informations['title']);
    }
    
    if (isset($setting['status']) && $setting['status']) {
      if (version_compare(VERSION, '2.1.0.2', '<=')) {
        if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/extension/ocdevwizard/'.$this->_name.'/static.tpl')) {
          return $this->load->view($this->config->get('config_template').'/template/extension/ocdevwizard/'.$this->_name.'/static.tpl', $data);
        } else {
          return $this->load->view('default/template/extension/ocdevwizard/'.$this->_name.'/static.tpl', $data);
        }
      } else if (version_compare(VERSION, '3.0.0.0', '>=')) {
        return $this->load->view('extension/ocdevwizard/'.$this->_name.'/static', $data);
      } else {
        return $this->load->view('extension/ocdevwizard/'.$this->_name.'/static.tpl', $data);
      }
    }
  }
  
  public function save_record() {
    $data = array();
    $json = array();
    
    $models = array(
      'catalog/information',
      'extension/ocdevwizard/'.$this->_name
    );
    
    foreach ($models as $model) {
      $this->load->model($model);
    }
    
    // get @form_id
    if (isset($this->request->request['form_id'])) {
      $form_id = (int)$this->request->request['form_id'];
    } else {
      die();
    }
    
    $data = array_merge($data, $this->language->load('extension/ocdevwizard/'.$this->_name));
    
    $form_data = $this->{'model_extension_ocdevwizard_'.$this->_name}->getForm($form_id);
    
    $language_id = $this->{'model_extension_ocdevwizard_'.$this->_name}->getLanguageByCode($this->session->data['language']);
    
    $store_id   = $this->config->get('config_store_id');
    $store_name = $this->config->get('config_name');
    $store_url  = (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) ? $this->config->get('config_ssl') : $this->config->get('config_url');
    
    if ($store_id != 0) {
      $store_info = $this->{'model_extension_ocdevwizard_'.$this->_name}->getStore($store_id);
      
      if ($store_info) {
        $store_name = $store_info['name'];
        $store_url  = (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) ? $store_info['ssl'] : $store_info['url'];
      }
    }
    
    $success_message = html_entity_decode($form_data['success_message'], ENT_QUOTES, 'UTF-8');
    
    // validate fields
    foreach ($this->getActiveField($form_id) as $field) {
      if ($field['check'] == 1 && empty($this->request->request[$field['name']])) {
        $json['error']['field'][$field['name']] = $field['error_text'][$language_id];
      } else if ($field['check'] == 2 && (!empty($field['check_rule']) && !preg_match($field['check_rule'], $this->request->request[$field['name']]))) {
        $json['error']['field'][$field['name']] = $field['error_text'][$language_id];
      } else if ($field['check'] == 3 && (utf8_strlen(str_replace(array(
            '_',
            '-',
            '(',
            ')',
            '+'
          ), "", $this->request->request[$field['name']])) < $field['check_min'] || utf8_strlen(str_replace(array(
            '_',
            '-',
            '(',
            ')',
            '+'
          ), "", $this->request->request[$field['name']])) > $field['check_max'])) {
        $json['error']['field'][$field['name']] = $field['error_text'][$language_id];
      } else {
        unset($json['error']['field'][$field['name']]);
      }
    }
    
    // validate require information
    if (!isset($this->request->request['require_information']) || empty($this->request->request['require_information'])) {
      if (isset($form_data['require_information']) && $form_data['require_information']) {
        $informations                                  = (array)$this->model_catalog_information->getInformation((int)$form_data['require_information']);
        $json['error']['field']['require_information'] = sprintf($this->language->get('error_require_information'), $informations['title']);
      }
    }
    
    if (!isset($json['error'])) {
      $post_fields = array();
      
      foreach ($this->getActiveField($form_id) as $key => $field) {
        if (isset($this->request->request[$field['name']])) {
          $post_fields[] = array(
            'title' => $field['title'][$language_id],
            'value' => $this->request->request[$field['name']]
          );
        }
      }
      
      if (!empty($this->request->server['REMOTE_ADDR'])) {
        $ip = $this->request->server['REMOTE_ADDR'];
      } else {
        $ip = '';
      }
      
      if (!empty($this->request->server['HTTP_REFERER'])) {
        $referer = $this->request->server['HTTP_REFERER'];
      } else {
        $referer = '';
      }
      
      if (isset($this->request->server['HTTP_USER_AGENT'])) {
        $user_agent = $this->request->server['HTTP_USER_AGENT'];
      } else {
        $user_agent = '';
      }
      
      if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
        $accept_language = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
      } else {
        $accept_language = '';
      }
      
      $filter_data = array(
        'form_id'          => $form_id,
        'ip'               => $ip,
        'referer'          => $referer,
        'user_agent'       => $user_agent,
        'accept_language'  => $accept_language,
        'user_language_id' => $language_id,
        'field_data'       => $post_fields,
        'store_name'       => $store_name,
        'store_url'        => $store_url,
        'store_id'         => $store_id
      );
      
      $this->{'model_extension_ocdevwizard_'.$this->_name}->addRecord($filter_data);
      
      $json['output'] = strip_tags($success_message);
    }
    
    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }
  
  public function getActiveField($form_id) {
    $models = array(
      'extension/ocdevwizard/'.$this->_name
    );
    
    foreach ($models as $model) {
      $this->load->model($model);
    }
    
    $form_data = $this->{'model_extension_ocdevwizard_'.$this->_name}->getForm($form_id);
    
    $fields = unserialize($form_data['field_data']);
    
    foreach ($fields as $key => $field) {
      if ($field['activate'] == 0) {
        unset($fields[$key]);
      }
    }
    
    return $fields;
  }
}