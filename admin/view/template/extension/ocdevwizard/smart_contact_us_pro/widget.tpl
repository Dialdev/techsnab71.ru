<!--
##==================================================================##
## @author    : OCdevWizard                                         ##
## @contact   : ocdevwizard@gmail.com                               ##
## @support   : http://help.ocdevwizard.com                         ##
## @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf ##
## @copyright : (c) OCdevWizard. Smart Contact Us Pro, 2017         ##
##==================================================================##
-->
<div class="tile">
  <div class="tile-heading">
    <?php echo $heading_title; ?>
  </div>
  <div class="tile-body"><i class="fa fa-envelope-o" aria-hidden="true"></i>
		<div class="table-responsive">
			<table class="table smcm-table" style="margin-bottom: 0;">
	    	<tr>
	    		<td><?php echo $text_total_smart_contact_us_pro_1; ?></td>
	    		<td class="text-right"><?php echo $total_viewed; ?></td>
	    	</tr>
	    	<tr>
	    		<td><?php echo $text_total_smart_contact_us_pro_2; ?></td>
	    		<td class="text-right"><?php echo $total_not_viewed; ?></td>
	    	</tr>
	    	<tr>
	    		<td><?php echo $text_total_smart_contact_us_pro_3; ?></td>
	    		<td class="text-right"><?php echo $total; ?></td>
	    	</tr>
  		</table>
  	</div>
  </div>
  <div class="tile-footer"><a href="<?php echo $link; ?>"><?php echo $button_view_more; ?></a></div>
</div>