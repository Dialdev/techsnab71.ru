<!--
##==================================================================##
## @author    : OCdevWizard                                         ##
## @contact   : ocdevwizard@gmail.com                               ##
## @support   : http://help.ocdevwizard.com                         ##
## @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf ##
## @copyright : (c) OCdevWizard. Smart Popup Cart Pro Plus, 2017    ##
##==================================================================##
-->

<?php if ($histories) { ?>
  <div class="btn-group">
    <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
      <i class="fa fa-trash-o"></i> <?php echo $button_delete_menu; ?> <span class="caret"></span>
    </button>
    <ul class="dropdown-menu" role="menu">
      <li><a onclick="delete_all('2','email-template');"><?php echo $button_delete_all; ?></a></li>
      <li><a onclick="delete_all_selected('2','email-template');"><?php echo $button_delete_selected; ?></a></li>
    </ul>
  </div>
<?php } ?>
<button type="button" onclick="$('a[href=#email-template-constructor-block]').click();" class="btn btn-primary"><i class="fa fa-refresh"></i> <?php echo $button_update; ?></button>
<button type="button" onclick="open_email_template();" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add_email_template; ?></button>
<div class="special-margin"></div>
<div class="table-responsive">
  <table class="table table-bordered">
    <thead>
      <tr>
        <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('#history-email-template input[name*=\'selected\']').attr('checked', this.checked);" /></td>
        <td class="text-left" width="15%"><?php echo $column_email_template_name; ?></td>
        <td class="text-left"><?php echo $column_email_template_date; ?></td>
        <td class="text-left"><?php echo $column_email_template_status; ?></td>
        <td class="text-left"><?php echo $column_email_template_action; ?></td>
      </tr>
    </thead>
    <tbody>
    <?php if ($histories) { ?>
      <?php foreach ($histories as $history) { ?>
      <tr>
        <td style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $history['template_id']; ?>" /></td>
        <td class="text-left"><?php echo $history['name']; ?></td>
        <td class="text-left">
          <p><strong><?php echo $text_date_added; ?></strong> <?php echo $history['date_added']; ?></p>
          <?php if ($history['date_modified'] != '0000-00-00 00:00:00') { ?>
          <p><strong><?php echo $text_date_modified; ?></strong> <?php echo $history['date_modified']; ?></p>
          <?php } ?>
        </td>
        <td class="text-left"><?php echo $history['status']; ?></td>
        <td class="text-center">
          <button type="button" class="btn btn-primary" onclick="open_email_template({id: '<?php echo $history['template_id']; ?>'});" data-toggle="tooltip" title="" data-original-title="<?php echo $button_edit; ?>"><i class="fa fa-pencil"></i></button>
          <a onclick="confirm('<?php echo $text_are_you_sure; ?>') ? delete_selected('2','email-template',<?php echo $history['template_id']; ?>) : false;" data-toggle="tooltip" title="" class="btn btn-warning" data-original-title="<?php echo $button_delete; ?>"><i class="fa fa-trash-o"></i></a>
          <button type="button" class="btn btn-default" onclick="confirm('<?php echo $text_are_you_sure; ?>') ? copy_selected('<?php echo $history['template_id']; ?>', 'email-template') : false;" data-toggle="tooltip" title="" data-original-title="<?php echo $button_copy; ?>"><i class="fa fa-copy"></i></button>
        </td>
      </tr>
      <?php } ?>
      <?php } else { ?>
        <tr>
          <td class="text-center" colspan="5"><?php echo $text_no_results; ?></td>
        </tr>
      <?php } ?>
    </tbody>
  </table>
</div>
<?php if ($histories) { ?>
<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
<?php } ?>