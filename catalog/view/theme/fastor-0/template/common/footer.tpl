<?php 
if($this->registry->has('theme_options') == true) { 
	$theme_options = $this->registry->get('theme_options');
	$config = $this->registry->get('config');
	
	require_once( DIR_TEMPLATE.$config->get('config_template')."/lib/module.php" );
	$modules = new Modules($this->registry);
	
	// Pobranie zmiennych
	$language_id = $config->get( 'config_language_id' );
	$customfooter = $theme_options->get( 'customfooter' );
	if(!isset($customfooter[$language_id])) {
		$customfooter[$language_id] = array(
			'aboutus_status' => 0,
			'twitter_status' => 0,
			'facebook_status' => 0,
			'contact_status' => 0,
			'customblock_status' => 0
		);
	}
	
	if(!isset($customfooter[$language_id]['customblock_status'])) $customfooter[$language_id]['customblock_status'] = 0;
	
	$customfooter_top = $modules->getModules('customfooter_top');
	$customfooter_bottom = $modules->getModules('customfooter_bottom');
	$customfooter_center = $modules->getModules('customfooter');
	$footer_center = $modules->getModules('footer');
	
	// Sprawdzanie czy panele są włączone
	if(isset($customfooter[$language_id]) || count($customfooter_top) || count($customfooter_bottom) || count($customfooter_center)) { 
		if($customfooter[$language_id]['twitter_status'] == '1' || $customfooter[$language_id]['contact_status'] == '1' || $customfooter[$language_id]['aboutus_status'] == '1' || $customfooter[$language_id]['facebook_status'] == '1' || count($customfooter_top) || count($customfooter_bottom) || count($customfooter_center)) { 
			
			// Ustalanie szerokości paneli
			$grids = 12; $test = 0;  
			if($customfooter[$language_id]['aboutus_status'] == '1') { $test++; } 
			if($customfooter[$language_id]['twitter_status'] == '1') { $test++; } 
			if($customfooter[$language_id]['facebook_status'] == '1') { $test++; } 
			if($customfooter[$language_id]['contact_status'] == '1') { $test++; } 
			if($customfooter[$language_id]['customblock_status'] == '1') { $test++; } 
			if($test == 0) { $test = 1; }
			$grids = 12/$test; 
			if($test == 5) $grids = 25;
	
	?>
	<!-- CUSTOM FOOTER
		================================================== -->
	<div class="custom-footer <?php if($theme_options->get( 'custom_footer_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'custom_footer_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'custom_footer_layout' ) == 3) { echo 'fixed2'; } else { echo 'fixed'; } ?>">
		<div class="background-custom-footer"></div>
		<div class="background">
			<div class="shadow"></div>
			<div class="pattern">
				<div class="container">
					<?php 
					if( count($customfooter_top) ) { 
						foreach ($customfooter_top as $module) {
							echo $module;
						}
					} ?>
					
					<?php 
					if( count($customfooter_center) ) { 
						foreach ($customfooter_center as $module) {
							echo $module;
						}
					} else { ?>
     					<div class="row">
     						<?php if($customfooter[$language_id]['aboutus_status'] == '1') { ?>
     						<!-- About us -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['aboutus_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['aboutus_title']; ?></h4>
     							<?php } ?>
     							<div class="custom-footer-text"><?php echo html_entity_decode($customfooter[$language_id]['aboutus_text']); ?></div>
     						</div>
     						<?php } ?>
     						
     						<?php if($customfooter[$language_id]['contact_status'] == '1') { ?>
     						<!-- Contact -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['contact_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['contact_title']; ?></h4>
     							<?php } ?>
     							<ul class="contact-us clearfix">
     								<?php if($customfooter[$language_id]['contact_phone'] != '' || $customfooter[$language_id]['contact_phone2'] != '') { ?>
     								<!-- Phone -->
     								<li>
     									<i class="fa fa-mobile-phone"></i>
     									<p>
     										<?php if($customfooter[$language_id]['contact_phone'] != '') { ?>
     											<?php echo $customfooter[$language_id]['contact_phone']; ?><br>
     										<?php } ?>
     										<?php if($customfooter[$language_id]['contact_phone2'] != '') { ?>
     											<?php echo $customfooter[$language_id]['contact_phone2']; ?>
     										<?php } ?>
     									</p>
     								</li>
     								<?php } ?>
     								<?php if($customfooter[$language_id]['contact_email'] != '' || $customfooter[$language_id]['contact_email2'] != '') { ?>
     								<!-- Email -->
     								<li>
     									<i class="fa fa-envelope"></i>
     									<p>
     										<?php if($customfooter[$language_id]['contact_email'] != '') { ?>
     											<span><?php echo $customfooter[$language_id]['contact_email']; ?></span><br>
     										<?php } ?>
     										<?php if($customfooter[$language_id]['contact_email2'] != '') { ?>
     											<span><?php echo $customfooter[$language_id]['contact_email2']; ?></span>
     										<?php } ?>
     									</p>
     								</li>
     								<?php } ?>
     								<?php if($customfooter[$language_id]['contact_skype'] != '' || $customfooter[$language_id]['contact_skype2'] != '') { ?>
     								<!-- Phone -->
     								<li>
     									<i class="fa fa-skype"></i>
     									<p>
     										<?php if($customfooter[$language_id]['contact_skype'] != '') { ?>
     											<?php echo $customfooter[$language_id]['contact_skype']; ?><br>
     										<?php } ?>
     										<?php if($customfooter[$language_id]['contact_skype2'] != '') { ?>
     											<?php echo $customfooter[$language_id]['contact_skype2']; ?>
     										<?php } ?>
     									</p>
     								</li>
     								<?php } ?>
     							</ul>
     						</div>
     						<?php } ?>
     						
     						<?php if($customfooter[$language_id]['twitter_status'] == '1') { ?>
     						<!-- Twitter -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['twitter_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['twitter_title']; ?></h4>
     							<?php } ?>
     							
     							<div class="clear">
     								<a class="twitter-timeline" href="https://twitter.com/<?php echo $customfooter[$language_id]['twitter_widget_id'] ; ?>" data-tweet-limit="2">Tweets by <?php echo $customfooter[$language_id]['twitter_widget_id'] ; ?></a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
     							</div>
     						</div>
     						<?php } ?>
     						
     						<?php if($customfooter[$language_id]['facebook_status'] == '1') { ?>
     						<!-- Facebook -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['facebook_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['facebook_title']; ?></h4>
     							<?php } ?>
     							
     							<div id="fb-root"></div>
     							<script>(function(d, s, id) {
     							  var js, fjs = d.getElementsByTagName(s)[0];
     							  if (d.getElementById(id)) return;
     							  js = d.createElement(s); js.id = id;
     							  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
     							  fjs.parentNode.insertBefore(js, fjs);
     							}(document, 'script', 'facebook-jssdk'));</script>
     														
     							<div id="facebook">
     								<?php if(!isset($customfooter[$language_id]['color_scheme'])) { $customfooter[$language_id]['color_scheme'] = false; } ?>
     								<div class="fb-like-box fb_iframe_widget" profile_id="<?php echo $customfooter[$language_id]['facebook_id']; ?>" data-show-border="false"
     								 data-width="260" data-height="<?php if($customfooter[$language_id]['facebook_height'] > 0) { echo $customfooter[$language_id]['facebook_height']; } else { echo '210'; } ?>" <?php if($customfooter[$language_id]['show_faces'] != '1') { ?>data-connections="<?php if($customfooter[$language_id]['facebook_faces'] > 0) { echo $customfooter[$language_id]['facebook_faces']; } else { echo '8'; } ?>"<?php } ?> data-colorscheme="<?php if($customfooter[$language_id]['color_scheme'] != '1') { echo 'light'; } else { echo 'dark'; } ?>" data-stream="false" data-header="false" data-show-faces="<?php if($customfooter[$language_id]['show_faces'] == '1') { echo 'false'; } else { echo 'true'; } ?>" fb-xfbml-state="rendered"></div>
     							</div>
     						</div>
     						<?php } ?>
     						
     						<?php if($customfooter[$language_id]['customblock_status'] == '1') { ?>
     						<!-- Custom block -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['customblock_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['customblock_title']; ?></h4>
     							<?php } ?>
     							<div class="custom-footer-text"><?php echo html_entity_decode($customfooter[$language_id]['customblock_text']); ?></div>
     						</div>
     						<?php } ?>
     					</div>
					<?php } ?>
					
					<?php 
					if( count($customfooter_bottom) ) { 
						foreach ($customfooter_bottom as $module) {
							echo $module;
						}
					} ?>
				</div>
			</div>
		</div>
	</div>
	<?php } } ?>
	
	<!-- FOOTER
		================================================== -->
	<div class="footer <?php if($theme_options->get( 'footer_layout' ) == 2) { echo 'fixed'; } elseif($theme_options->get( 'footer_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'footer_layout' ) == 3) { echo 'fixed2'; } else { echo 'full-width'; } ?>">
		<div class="background-footer"></div>
		<div class="background">
			<div class="shadow"></div>
			<div class="pattern">
				<div class="container">					
					<?php 
					if( count($footer_center) ) { 
						foreach ($footer_center as $module) {
							echo $module;
						}
					} else { ?>
					     <?php 
					     $footer_top = $modules->getModules('footer_top');
					     if( count($footer_top) ) { 
					     	foreach ($footer_top as $module) {
					     		echo $module;
					     	}
					     } ?>
					     
     					<div class="row footer-main-box">
     						<?php 
     						$footer_left = $modules->getModules('footer_left');
     						$footer_right = $modules->getModules('footer_right');
     						
     						$span = 3;
     						if( count($footer_left) && count($footer_right) ) {
     							$span = 2;
     						} elseif( count($footer_left) || count($footer_right) ) {
     							$span = 25;
     						} ?>
     						
     						<?php if( count($footer_left) ) { ?>
     						<div class="col-sm-<?php echo $span; ?>">
     						<?php foreach ($footer_left as $module) {
     								echo $module;
     							} ?>
     						</div>
     						<?php } ?>
     						
     						<!-- Information -->
     						<div class="col-sm-<?php echo $span; ?>">
     							<h4><?php echo $text_information; ?></h4>
     							<div class="strip-line"></div>
     							<ul>
     								<?php foreach ($informations as $information) { ?>
     								<li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
     								<?php } ?>
     							</ul>
     						</div>
     						
     						<!-- Customer Service -->
     						<div class="col-sm-<?php echo $span; ?>">
     							<h4><?php echo $text_service; ?></h4>
     							<div class="strip-line"></div>
     							<ul>
     								<li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
     								<li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
     								<li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
     							</ul> 
     						</div>
     						
     						<!-- Extras -->
     						<div class="col-sm-<?php echo $span; ?>">
     							<h4><?php echo $text_extra; ?></h4>
     							<div class="strip-line"></div>
     							<ul>
     								<li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
     								<li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
     								<li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
     								<li><a href="<?php echo $special; ?>"><?php echo $text_special; ?> </a></li>
     							</ul>
     						</div>
     						
     						<!-- My Account -->
     						<div class="col-sm-<?php echo $span; ?>">
     							<h4><?php echo $text_account; ?></h4>
     							<div class="strip-line"></div>
     							<ul>
     								<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
     								<li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
     								<li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
     								<li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
     							</ul>
     						</div>
     						
     						<?php if( count($footer_right) ) { ?>
     						<div class="col-sm-<?php echo $span; ?>">
     						<?php foreach ($footer_right as $module) {
     								echo $module;
     							} ?>
     						</div>
     						<?php } ?>
     					</div>
     					
     					<?php 
     					$footer_bottom = $modules->getModules('footer_bottom');
     					if( count($footer_bottom) ) { 
     						foreach ($footer_bottom as $module) {
     							echo $module;
     						}
     					} ?>
     					
     					<div class="row copyright">
     					     <div class="col-sm-12">
     					          <?php if(is_array($theme_options->get( 'payment' ))) { if($theme_options->get( 'payment_status' ) != '0') { ?>
     					          <ul>
     					          	<?php foreach($theme_options->get( 'payment' ) as $payment) { 
     					          		echo '<li>';
     					          		if($payment['link'] != '') {
     					          			$new_tab = false;
     					          			if($payment['new_tab'] == 1) {
     					          				$new_tab = ' target="_blank"';
     					          			}
     					          			echo '<a href="' .$payment['link']. '"'.$new_tab.'>';
     					          		}
     					          		echo '<img src="image/' .$payment['img']. '" alt="' .$payment['name']. '">';
     					          		if($payment['link'] != '') {
     					          			echo '</a>';
     					          		}
     					          		echo '</li>'; 
     					          	} ?>
     					          </ul>
     					          <?php } } ?>
     					          <!--
     					          OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
     					          Please donate via PayPal to donate@opencart.com
     					          //-->
     					          <p><?php echo $powered; ?></p>
     					          <!--
     					          OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
     					          Please donate via PayPal to donate@opencart.com
     					          //-->
     					          
     					          <?php 
     					          $bottom = $modules->getModules('bottom');
     					          if( count($bottom) ) { 
     					          	foreach ($bottom as $module) {
     					          		echo $module;
     					          	}
     					          } ?>
     					     </div>
     					</div>
					<?php } ?>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="catalog/view/theme/<?php echo $config->get( 'config_template' ); ?>/js/megamenu.js"></script>
</div>
</div>
<?php } ?>
</body>
</html>