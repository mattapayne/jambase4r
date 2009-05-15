module JamBase4R
  
  module ViewHelper
    
    def jambase_text_attribution
      %{**Concert information provided by <a href="http://www.jambase.com">JamBase</a>**}
    end
    
    def jambase_image_attribution
      %{<a href="http://www.JamBase.com" target="_top" title="JamBase Concert Search">
          <img src= "http://images.jambase.com/logos/jambase140x70.gif" alt="Search JamBase Concerts" border="0" />
        </a>}
    end
    
    def jambase_favicon
      %{<a href="http://www.JamBase.com" target="_top" title="JamBase Concert Search">
          <img src= "http://www.jambase.com/favicon.ico" alt="Search JamBase Concerts" border="0" />
        </a>
      }
    end
    
  end
  
end
