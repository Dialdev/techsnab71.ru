<!--
##==================================================================##
## @author    : OCdevWizard                                         ##
## @contact   : ocdevwizard@gmail.com                               ##
## @support   : http://help.ocdevwizard.com                         ##
## @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf ##
## @copyright : (c) OCdevWizard. Smart Popup Cart Pro Plus, 2017    ##
##==================================================================##
-->
<div class="modal-content" id="modal-email-template-constructor-content">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
    <h4 class="modal-title" id="myModalLabel"><?php echo $text_modal_email_template; ?></h4>
  </div>
  <div class="modal-body">
    <div id="content" class="row" style="padding-bottom: 0;">
      <div class="panel-body" style="padding-top: 0;padding-bottom: 0;">
        <ul class="nav nav-tabs" id="modal-setting-tabs">
          <li class="active"><a href="#modal-general-block" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_general_setting; ?></a></li>
          <li><a href="#modal-email-template-block" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_email_template_setting; ?></a></li>
        </ul>
        <form method="post" enctype="multipart/form-data" id="modal-form" class="form-horizontal">
          <input type="hidden" style="display:none;" name="template_id" value="<?php echo $template_id; ?>" />
          <div class="tab-content">
            <!-- TAB Modal general block -->
            <div class="tab-pane fade active in" role="tabpanel" id="modal-general-block">
              <div class="form-group">
                <label class="col-sm-3 control-label"><?php echo $text_activate_email_template; ?></label>
                <div class="col-sm-9">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $status == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="status"
                        value="1"
                        autocomplete="off"
                        <?php echo $status == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $status == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="status"
                        value="0"
                        autocomplete="off"
                        <?php echo $status == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-3 control-label"><?php echo $text_email_template_name; ?></label>
                <div class="col-sm-9">
                  <input name="name" type="text" value="<?php echo $name; ?>" class="form-control" />
                  <div class="modal-error-block" id="modal-error-name"></div>
                </div>
              </div>
            </div>
            <!-- TAB Email template block -->
            <div class="tab-pane fade" role="tabpanel" id="modal-email-template-block">
              <div class="form-group required">
                <label class="col-sm-3 control-label"><?php echo $text_email_template_subject; ?></label>
                <div class="col-sm-9">
                  <?php foreach ($languages as $language) { ?>
                  <div class="input-group" style="margin-bottom: 5px;">
                    <span class="input-group-addon"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                    <input type="text" name="template_description[<?php echo $language['language_id']; ?>][subject]" value="<?php echo isset($template_description[$language['language_id']]) ? $template_description[$language['language_id']]['subject'] : ''; ?>" class="form-control" />
                  </div>
                  <div class="modal-error-block" id="modal-error-form-description-language-subject-<?php echo $language['language_id']; ?>"></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-3 control-label"><?php echo $text_email_template_html; ?></label>
                <div class="col-sm-9">
                  <?php foreach ($languages as $language) { ?>
                  <div class="input-group" style="margin-bottom: 5px;">
                    <span class="input-group-addon"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                    <textarea name="template_description[<?php echo $language['language_id']; ?>][template]" id="template<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($template_description[$language['language_id']]) ? $template_description[$language['language_id']]['template'] : ''; ?></textarea>
                    <?php if ($template_id) { ?>
                    <span class="input-group-addon"><button type="button" data-toggle="tooltip" class="btn btn-primary btn-xs" title="<?php echo $button_preview_result; ?>" onclick="preview_email_template('<?php echo $language['language_id']; ?>', '<?php echo $template_id; ?>');"><i class="fa fa-eye"></i></button></span>
                    <?php } ?>
                  </div>
                  <div class="btn-group">
                    <button type="button" class="btn btn-default btn-xs" onclick="texteditor_action({id: '#template<?php echo $language['language_id']; ?>'});"><?php echo $text_open_texteditor; ?></button>
                    <button type="button" class="btn btn-default btn-xs" onclick="texteditor_action({id: '#template<?php echo $language['language_id']; ?>', start: false, destroy: true});" style="display: none;"><?php echo $text_save_texteditor; ?></button>
                  </div>
                  <div class="modal-error-block" id="modal-error-template-description-language-template-<?php echo $language['language_id']; ?>"></div>
                  <?php } ?>
                  <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapse-result-email-sub" aria-expanded="false" aria-controls="collapse-result-email-sub"><?php echo $button_view_shortcodes; ?></button>
                </div>
              </div>
              <div class="collapse" id="collapse-result-email-sub">
                <div class="form-group" style="margin-bottom: 0px;">
                  <div class="col-sm-3"></div>
                  <div class="col-sm-9">
                    <div class="well">
                      <?php echo $text_result_email_sub_h1; ?><br/>
                      <?php echo $text_result_email_sub_c1; ?><br/><br/>
                      <?php echo $text_result_email_sub_h2; ?><br/>
                      <?php echo $text_result_email_sub_c2; ?><br/><br/>
                      <?php echo $text_result_email_sub_h3; ?><br/>
                      <?php echo $text_result_email_sub_c3; ?>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="modal-footer">
    <button type="button" class="btn btn-info" onclick="submit_email_template(this, <?php if ($template_id) { ?>'edit'<?php } else { ?>'add'<?php } ?>);"><?php echo $button_submit; ?></button>
    <button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close" <?php if (!$template_id) { ?>style="display: none;"<?php } ?>><?php echo $button_close; ?></button>
  </div>
</div>