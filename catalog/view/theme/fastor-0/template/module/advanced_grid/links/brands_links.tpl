<?php 
if($position == 'footer_bottom' || $position == 'footer' || $position == 'footer_top' || $position == 'footer_left' || $position == 'footer_right' || $position == 'customfooter_top' || $position == 'customfooter_bottom' || $position == 'customfooter') {
	if($module['content']['title'] != '') {
	     echo '<h4>'.$module['content']['title'].'</h4>';
	} else {
	     echo '<div style="height:13px"></div>';
	}
	echo '<div class="strip-line"></div>';
	
	if($module['content']['limit'] < 1) { $module['content']['limit'] = 20; }
	
	$count_columns = ceil(count($module['content']['links'])/$module['content']['limit']);
	$class = 3; 
	
	if($count_columns == 1) $class = 12;
	if($count_columns == 2) $class = 6;
	if($count_columns == 3) $class = 4;
	if($count_columns == 4) $class = 3;
	if($count_columns == 5) $class = 25;
	if($count_columns == 6) $class = 2;
	
	echo '<div class="row" style="clear: both" id="brands-links">';
	     echo '<div class="col-sm-' . $class . '">';
	          echo '<ul>';
	               $i = 0;
               	foreach($module['content']['links'] as $link) {
               	     if($module['content']['limit'] == $i) {
               	          $i = 0;
               	          echo '</ul></div><div class="col-sm-' . $class . '"><ul>';
               	     }
               	     
               	        if(is_array($link['url'])) {
               	        	$nowy_link = $link['url'];
               	        	$language_id = $config->get( 'config_language_id' );
               	        	if(isset($nowy_link[$language_id])) {
               	        		$link['url'] = $nowy_link[$language_id];
               	        	} else {
               	        		$link['url'] = '';
               	        	}
               	        }
               	     
               	     echo '<li><a href="' . $link['url'] . '">' . html_entity_decode($link['name'], ENT_QUOTES, 'UTF-8') . '</a></li>';
               	     $i++;
               	}
               echo '</ul>';
          echo '</div>';
     echo '</div>';
} else {
	echo '<div class="box">';
		echo '<div class="box-heading">';
			echo $module['content']['title'];
		echo '</div>';
		echo '<div class="strip-line"></div>';
		echo '<div class="box-content">';
			if($module['content']['limit'] < 1) { $module['content']['limit'] = 20; }
			
			$count_columns = ceil(count($module['content']['links'])/$module['content']['limit']);
			$class = 3; 
			
			if($count_columns == 1) $class = 12;
			if($count_columns == 2) $class = 6;
			if($count_columns == 3) $class = 4;
			if($count_columns == 4) $class = 3;
			if($count_columns == 5) $class = 25;
			if($count_columns == 6) $class = 2;
			
			echo '<div class="row" id="brands-links">';
			     echo '<div class="col-sm-' . $class . '">';
			          echo '<ul>';
			               $i = 0;
			          	foreach($module['content']['links'] as $link) {
			          	     if($module['content']['limit'] == $i) {
			          	          $i = 0;
			          	          echo '</ul></div><div class="col-sm-' . $class . '"><ul>';
			          	     }
			          	     
			          	        if(is_array($link['url'])) {
			          	        	$nowy_link = $link['url'];
			          	        	$language_id = $config->get( 'config_language_id' );
			          	        	if(isset($nowy_link[$language_id])) {
			          	        		$link['url'] = $nowy_link[$language_id];
			          	        	} else {
			          	        		$link['url'] = '';
			          	        	}
			          	        }
			          	     
			          	     echo '<li><a href="' . $link['url'] . '">' . $link['name'] . '</a></li>';
			          	     $i++;
			          	}
			          echo '</ul>';
			     echo '</div>';
			echo '</div>';
		echo '</div>';
	echo '</div>';	
} ?>