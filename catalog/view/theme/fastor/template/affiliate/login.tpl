<?php echo $header; 
$theme_options = $this->registry->get('theme_options');
$config = $this->registry->get('config'); 
include('catalog/view/theme/' . $config->get('config_template') . '/template/new_elements/wrapper_top.tpl'); ?>

<?php echo $text_description; ?>
<div class="row">
  <div class="col-sm-6">
    <div class="well">
      <h2><?php echo $text_new_affiliate; ?></h2>
      <p><?php echo $text_register_account; ?></p>
      <a class="btn btn-primary" href="<?php echo $register; ?>" style="margin-top: 10px"><?php echo $button_continue; ?></a></div>
  </div>
  <div class="col-sm-6">
    <div class="well">
      <h2><?php echo $text_returning_affiliate; ?></h2>
      <p><strong><?php echo $text_i_am_returning_affiliate; ?></strong></p>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="form-group">
          <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
          <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
        </div>
        <div class="form-group" style="padding-bottom: 10px">
          <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
          <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
          <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a> </div>
        <input type="submit" value="<?php echo $button_login; ?>" class="btn btn-primary" />
        <?php if ($redirect) { ?>
        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        <?php } ?>
      </form>
    </div>
  </div>
</div>
  
<?php include('catalog/view/theme/' . $config->get('config_template') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>