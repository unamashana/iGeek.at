module ApplicationHelper

  def share_the_love
    <<-eos
      <span  class='st_twitter_hcount' displayText='Tweet'></span><span  class='st_facebook_hcount' displayText='Facebook'></span><span  class='st_plusone_hcount' ></span>
      <script type="text/javascript">var switchTo5x=true;</script><script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script><script type="text/javascript">stLight.options({publisher:'bf4d5ef3-76c1-4c08-ab03-5cc70b7cd86e'});</script>
    eos


  end

end
