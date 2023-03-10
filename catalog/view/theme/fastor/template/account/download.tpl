<?php echo $header; 
$theme_options = $this->registry->get('theme_options');
$config = $this->registry->get('config'); 
include('catalog/view/theme/' . $config->get('config_template') . '/template/new_elements/wrapper_top.tpl'); ?>

<?php if ($downloads) { ?>
<table class="table table-bordered table-hover">
  <thead>
    <tr>
      <td class="text-right"><?php echo $column_order_id; ?></td>
      <td class="text-left"><?php echo $column_name; ?></td>
      <td class="text-left"><?php echo $column_size; ?></td>
      <td class="text-left"><?php echo $column_date_added; ?></td>
      <td></td>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($downloads as $download) { ?>
    <tr>
      <td class="text-right"><?php echo $download['order_id']; ?></td>
      <td class="text-left"><?php echo $download['name']; ?></td>
      <td class="text-left"><?php echo $download['size']; ?></td>
      <td class="text-left"><?php echo $download['date_added']; ?></td>
      <td><a href="<?php echo $download['href']; ?>" data-toggle="tooltip" title="<?php echo $button_download; ?>" class="btn btn-primary"><i class="fa fa-cloud-download"></i></a></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="row pagination-results" style="padding-top: 0;margin-top: -15px">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
<?php } else { ?>
<p><?php echo $text_empty; ?></p>
<?php } ?>
<div class="buttons clearfix">
  <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
</div>
  
<?php include('catalog/view/theme/' . $config->get('config_template') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>