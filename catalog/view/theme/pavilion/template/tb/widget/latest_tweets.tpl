<?php if($show_follow_button == '1' && $display_type == 'custom'): ?>
<a href="https://twitter.com/<?php echo $twitter_username; ?>" class="twitter-follow-button right" data-show-count="false" data-lang="<?php echo $follow_button_lang; ?>" data-show-screen-name="false">Follow @<?php echo $twitter_username; ?></a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
<?php endif; ?>
<?php if($title): ?>
<h2><?php echo $title; ?></h2>
<?php endif; ?>
<?php if ($display_type == 'custom'): ?>
<div class="tb_tweets tb_listing tb_list_view tb_style_<?php echo $style; ?><?php if ($hover_actions) echo ' tb_has_hover'; ?>">

  <?php if (isset($tweets['error'])): ?>
  <?php foreach ($tweets['error'] as $error): ?>
  <h3>twitter errors:</h3>
  <p style="color: red"><?php echo $error['text']; ?></p>
  <?php endforeach; ?>

  <?php elseif ($tweets): ?>
  <?php foreach ($tweets as $tweet): ?>
  <div class="tb_tweet tb_item">
    <?php if ($style != '3'): ?>
    <a class="tb_thumb" href="https://twitter.com/<?php echo $tweet['screen_name']; ?>"><img src="<?php echo $tweet['avatar']; ?>" alt="<?php echo $tweet['name']; ?>" /></a>
    <?php endif; ?>
    <div class="tb_item_info">
      <?php if ($style != '3'): ?>
      <h3><a href="https://twitter.com/<?php echo $tweet['screen_name']; ?>"><?php echo $tweet['name']; ?> <small class="tb_text_str_3">@<?php echo $tweet['screen_name']; ?></small></a></h3>
      <?php endif; ?>
      <p class="tb_status"><?php echo $tweet['text']; ?></p>
      <?php if (isset($tweet['time_ago'])): ?>
      <a class="tb_date tb_text_str_2 tb_main_color_hover" href="https://twitter.com/<?php echo $twitter_username; ?>/status/<?php echo $tweet['id_str']; ?>"><?php echo $tweet['time_ago']; ?></a>
      <?php endif; ?>
    </div>
    <?php if ($hover_actions): ?>
    <div class="tb_actions">
      <a class="tb_button_reply fa-reply" href="https://twitter.com/intent/tweet?in_reply_to=<?php echo $tweet['id_str']; ?>" title="<?php echo $tbData->text_reply; ?>"> <?php echo $tbData->text_reply; ?></a>&nbsp;&nbsp;
      <a class="tb_button_retweet fa-retweet" href="https://twitter.com/intent/retweet?tweet_id=<?php echo $tweet['id_str']; ?>" title="<?php echo $tbData->text_retweet; ?>"> <?php echo $tbData->text_retweet; ?></a>&nbsp;&nbsp;
      <a class="tb_button_favorite fa-star" href="https://twitter.com/intent/favorite?tweet_id=<?php echo $tweet['id_str']; ?>" title="<?php echo $tbData->text_favorite; ?>"> <?php echo $tbData->text_favorite; ?></a>
    </div>
    <?php endif; ?>
  </div>
  <?php endforeach; ?>
  <?php else: ?>
  <div class="tb_empty">No tweets</div>
  <?php endif; ?>
</div>
<?php else: ?>
<div class="tb_widget_holder">
  <?php echo $twitter_code; ?>
</div>
<?php endif; ?>
