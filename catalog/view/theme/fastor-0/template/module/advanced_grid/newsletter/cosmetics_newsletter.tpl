<?php $theme_options = $this->registry->get('theme_options');
$config = $this->registry->get('config'); ?>

<div class="newsletter cosmetics-newsletter clearfix row" id="newsletter<?php echo $id; ?>">
     <div class="col-sm-4">
          <div class="heading">
               <img src="image/catalog/cosmetics/icon-newsletter.png" alt="Newsletter">
               <p><?php echo $module['content']['title']; ?></p>
          </div>
     </div>
     
     <div class="content col-sm-4">
          <p><?php echo $module['content']['text']; ?></p>
     </div>
     
     <div class="inputs col-sm-4">
          <input type="text" class="email" placeholder="<?php echo $module['content']['input_placeholder']; ?>" />
          <a class="button btn-default subscribe"><?php echo $module['content']['subscribe_text']; ?></a>
     </div>
</div>

<?php if($theme_options->get( 'rodo_status' ) == '1') { ?>
	<div class="newsletter_rodo">
		<form id="agree_rodo_form2">
			<input type="checkbox" name="agree_rodo2" value="1" required="required">&nbsp;<?php echo html_entity_decode($theme_options->get( 'rodo_text', $config->get( 'config_language_id' ) )); ?>
			<input type="submit" class="submit hidden" value="Submit">
		</form>
	</div>
<?php } ?>


<script type="text/javascript">
$(document).ready(function() {
	function Unsubscribe() {
		$.post('<?php echo $module['content']['unsubscribe_url']; ?>', 
			{ 
				email: $('#newsletter<?php echo $id; ?> .email').val() 
			}, function (e) {
				$('#newsletter<?php echo $id; ?> .email').val('');
				alert(e.message);
			}
		, 'json');
	}
	
	function Subscribe() {
		<?php if($theme_options->get( 'rodo_status' ) == '1') { ?>
		if($('input[name="agree_rodo2"]').is(':checked')) {
		<?php } ?>
		$.post('<?php echo $module['content']['subscribe_url']; ?>', 
			{ 
				email: $('#newsletter<?php echo $id; ?> .email').val() 
			}, function (e) {
				if(e.error === 1) {
					var r = confirm(e.message);
					if (r == true) {
					    $.post('<?php echo $module['content']['unsubscribe_url']; ?>', { 
					    	email: $('#newsletter<?php echo $id; ?> .email').val() 
					    }, function (e) {
					    	$('#newsletter<?php echo $id; ?> .email').val('');
					    	alert(e.message);
					    }, 'json');
					}
				} else {
					$('#newsletter<?php echo $id; ?> .email').val('');
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
	
	$('#newsletter<?php echo $id; ?> .subscribe').click(Subscribe);
	$('#newsletter<?php echo $id; ?> .unsubscribe').click(Unsubscribe);
	$('#newsletter<?php echo $id; ?> .email').keypress(function (e) {
	    if (e.which == 13) {
	        Subscribe();
	    }
	});
});
</script>