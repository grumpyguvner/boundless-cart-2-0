<div class="mightySlider mightyslider_custom_skin <?php echo $slider['css_class']; ?>">
  <div class="frame"<?php echo $slider['frame_attributes']; ?>>
    <div class="slideelement">
      <?php $slide_num = 1; foreach ($slider['slides'] as $slide): ?>
      <div <?php echo str_replace('{{uid}}', $uid, $slide['attributes']); ?>>
        <?php if ($slide['link_url']): ?>
        <a href="<?php echo $slide['link_url']; ?>" target="<?php echo $slide['link_target']; ?>">
        <?php endif; ?>
        <?php if (!empty($slide['layers'])): ?>
        <div class="ms_scene">
          <?php $layer_num = 1; foreach ($slide['layers'] as $layer): if ($layer['background_origin'] == 'content'): ?>
          <div <?php echo str_replace('{{uid}}', $uid, $layer['attributes']); ?>>
            <?php if ($layer['link_url']): ?>
            <a href="<?php echo $layer['link_url']; ?>" target="<?php echo $layer['link_target']; ?>">
            <?php endif; ?>
            <?php if ($layer['type'] == 'html'): ?>
            <?php echo $layer['content']; ?>
            <?php else: ?>
            <img src="<?php echo $layer['image_src']; ?>"<?php if ($layer['image_width']) echo ' width="' . $layer['image_width'] . '"'; if ($layer['image_height']) echo ' height="' . $layer['image_height'] . '"'; ?> alt="" />
            <?php endif; ?>
            <?php if ($layer['link_url']): ?>
            </a>
            <?php endif; ?>
          </div>
          <?php $layer_num ++; endif; endforeach; ?>
        </div>
        <?php $layer_num = 1; foreach ($slide['layers'] as $layer): if ($layer['background_origin'] == 'row'): ?>
        <div <?php echo str_replace('{{uid}}', $uid, $layer['attributes']); ?>>
          <?php if ($layer['link_url']): ?>
          <a href="<?php echo $layer['link_url']; ?>" target="<?php echo $layer['link_target']; ?>">
          <?php endif; ?>
          <?php if ($layer['type'] == 'html'): ?>
          <?php echo $layer['content']; ?>
          <?php else: ?>
          <img src="<?php echo $layer['image_src']; ?>"<?php if ($layer['image_width']) echo ' width="' . $layer['image_width'] . '"'; if ($layer['image_height']) echo ' height="' . $layer['image_height'] . '"'; ?> alt="" />
          <?php endif; ?>
          <?php if ($layer['link_url']): ?>
          </a>
          <?php endif; ?>
        </div>
        <?php $layer_num ++; endif; endforeach; ?>
        <?php endif; ?>
        <?php if ($slide['link_url']): ?>
        </a>
        <?php endif; ?>
      </div>
      <?php $slide_num ++; endforeach; ?>
    </div>
  </div>
</div>

<div class="tb_placeholder"></div>

<script type="text/javascript">

<?php // FULLSCREEN SLIDER ?>
<?php if ($slider['layout'] == 'fullscreen'): ?>
var $old_slider = $('#<?php echo $uid; ?>');
$('#<?php echo $uid; ?>').remove();
<?php if ($slider['header_style'] == 'visible'): ?>
var $new_slider = $old_slider.insertBefore('#content');
var new_slider_height = $(window).height() - $('#header_wrap').outerHeight();

$('#header_wrap').addClass('tb_header_visible')
$new_slider.height(new_slider_height);
<?php endif; ?>
<?php if ($slider['header_style'] == 'hidden'): ?>
var $new_slider = $old_slider.insertBefore('#wrapper');
var new_slider_height = $(window).height();

$new_slider.height(new_slider_height);
<?php endif; ?>
<?php if ($slider['header_style'] == 'overlay'): ?>
var $new_slider = $old_slider.insertBefore('#content');
var new_slider_height = $(window).height();

$('#header_wrap').addClass('tb_header_overlay');
$new_slider.height(new_slider_height);
<?php endif; ?>
<?php endif; ?>

tbApp.onScriptLoaded(function() {

<?php // SLIDER INIT ?>
var $slider = new mightySlider(
    '#<?php echo $uid; ?> .mightySlider .frame',
    {
        speed:       <?php echo $slider['speed']; ?>,
        easing:      '<?php echo $slider['easing']; ?>',
        startRandom: <?php echo $slider['random']; ?>,
        viewport:    '<?php echo $slider['viewport']; ?>',
        autoScale:   <?php echo $slider['layout'] == 'fullwidth' || $slider['layout'] == 'fullscreen' ? '0' : $slider['autoscale']; ?>,
        navigation: {
            slideSize:      '100%',
            keyboardNavBy:  'slides'
        }
        <?php if ($slide_num > 2): ?>
        , commands: {
            pages: 1,
            buttons: 1
        },
        pages: {
          activateOn: 'click'
        },
        dragging: {
            releaseSwing: 1
        }
        <?php else: ?>
        , dragging: {
            mouseDragging: 0,
            touchDragging: 0,
        }
        <?php endif; ?>
        <?php if ($slider['autoplay']): ?>
        , cycling: {
            cycleBy: 'slides',
            pauseTime: <?php echo $slider['pause_time']; ?>,
            pauseOnHover: <?php echo $slider['hover_pause']; ?>
        }
        <?php endif; ?>
    }
).init();

<?php // FULLWIDTH SLIDER ?>
<?php if ($slider['layout'] == 'fullwidth'): ?>
onSizeChange(function() {
    fireslider_fullwidth_resize($slider, <?php echo $slider['responsive_width']; ?>)
});
fireslider_fullwidth_resize($slider, <?php echo $slider['responsive_width']; ?>)
<?php endif; ?>

<?php // FULLSCREEN SLIDER ?>
<?php if ($slider['layout'] == 'fullscreen'): ?>
onSizeChange(function() {

    <?php if ($slider['header_style'] == 'visible'): ?>
    var slider_height = $(window).height() - $('#header_wrap').outerHeight();
    <?php endif; ?>
    <?php if ($slider['header_style'] == 'hidden'): ?>
    var slider_height = $(window).height();
    <?php endif; ?>
    <?php if ($slider['header_style'] == 'overlay'): ?>
    var slider_height = $(window).height();
    <?php endif; ?>

    $('#<?php echo $uid; ?>').height(slider_height);
    fireslider_fullscreen_resize($slider, $('#<?php echo $uid; ?>'), <?php echo $slider['responsive_width']; ?>, <?php echo $slider['responsive_height']; ?>, <?php echo $slider['offset_top']; ?>, <?php echo $slider['offset_left']; ?>)
});
fireslider_fullscreen_resize($slider, $('#<?php echo $uid; ?>'), <?php echo $slider['responsive_width']; ?>, <?php echo $slider['responsive_height']; ?>, <?php echo $slider['offset_top']; ?>, <?php echo $slider['offset_left']; ?>)
<?php endif; ?>

});
</script>