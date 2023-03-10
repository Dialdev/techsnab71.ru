<?php $theme_options = $this->registry->get('theme_options');
$config = $this->registry->get('config'); ?>

<div class="box box-no-advanced" id="newsletter<?php echo $module_id; ?>">
	<?php if($module_title != '') { ?>
	<div class="box-heading"><?php echo $module_title; ?></div>
	<div class="strip-line"></div>
	<?php } ?>
	<div class="box-content">
		<?php if($module_text != '') echo $module_text; ?>
		<input type="text" class="email" placeholder="<?php echo $input_placeholder; ?>" style="width: 100%;display: block;margin: 10px 0px 0px 0px" />
		<a class="button subscribe" style="margin: 10px 7px 0px 0px"><?php echo $subscribe_text; ?></a>
		<?php if($button_unsubscribe == 1) { ?>
			<a class="button unsubscribe" style="margin: 10px 7px 0px 0px"><?php echo $unsubscribe_text; ?></a>
		<?php } ?>
	</div>
</div>

<?php if($theme_options->get( 'rodo_status' ) == '1') { ?>
	<div class="newsletter_rodo2">
		<form id="agree_rodo_form2">
			<input type="checkbox" name="agree_rodo2" value="1" required="required">&nbsp;<?php echo html_entity_decode($theme_options->get( 'rodo_text', $config->get( 'config_language_id' ) )); ?>
			<input type="submit" class="submit hidden" value="Submit">
		</form>
	</div>
<?php } ?>

<script type="text/javascript">
$(document).ready(function() {
	function Unsubscribe() {
		$.post('<?php echo $unsubscribe_url; ?>', 
			{ 
				email: $('#newsletter<?php echo $module_id; ?> .email').val() 
			}, function (e) {
				$('#newsletter<?php echo $module_id; ?> .email').val('');
				alert(e.message);
			}
		, 'json');
	}
	
	function Subscribe() {
		<?php if($theme_options->get( 'rodo_status' ) == '1') { ?>
		if($('input[name="agree_rodo2"]').is(':checked')) {
		<?php } ?>
		$.post('<?php echo $subscribe_url; ?>', 
			{ 
				email: $('#newsletter<?php echo $module_id; ?> .email').val() 
			}, function (e) {
				if(e.error === 1) {
					var r = confirm(e.message);
					if (r == true) {
					    $.post('<?php echo $unsubscribe_url; ?>', { 
					    	email: $('#newsletter<?php echo $module_id; ?> .email').val() 
					    }, function (e) {
					    	$('#newsletter<?php echo $module_id; ?> .email').val('');
					    	alert(e.message);
					    }, 'json');
					}
				} else {
					$('#newsletter<?php echo $module_id; ?> .email').val('');
					alert(e.message);
				}
			}
		, 'json');
		<?php if($theme_options->get( 'rodo_status' ) == '1') { ?>
		} else {
			$('#agree_rodo_form2 .submit').click();
		}
		<?php } ?>
	}
	
	$('#newsletter<?php echo $module_id; ?> .subscribe').click(Subscribe);
	$('#newsletter<?php echo $module_id; ?> .unsubscribe').click(Unsubscribe);
	$('#newsletter<?php echo $module_id; ?> .email').keypress(function (e) {
	    if (e.which == 13) {
	        Subscribe();
	    }
	});
});
</script>