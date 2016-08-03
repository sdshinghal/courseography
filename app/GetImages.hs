 module GetImages 
    (getActiveGraphImage, getTimetableImage) where

import TimetableImageCreator (renderTable)
import qualified Data.Map as M
import System.Random
import Svg.Generator
import ImageConversion
import Happstack.Server
import Data.List.Utils (replace)

-- | If there is an active graph available, an image of that graph is created,
-- otherwise the Computer Science graph is created as a default. 
-- Either way, the resulting graph's .svg and .png names are returned. 
getActiveGraphImage :: Request -> IO (String, String)
getActiveGraphImage req = do
    let cookies = M.fromList $ rqCookies req
        graphName =
            replace "-" " " $
                maybe "Computer-Science" cookieValue (M.lookup "active-graph" cookies)
    getGraphImage graphName (M.map cookieValue cookies)

-- | Creates an image, and returns the name of the svg used to create the
-- image and the name of the image
getGraphImage :: String -> M.Map String String -> IO (String, String)
getGraphImage graphName courseMap = do
    gen <- newStdGen
    let (rand, _) = next gen
        svgFilename = show rand ++ ".svg"
        imageFilename = show rand ++ ".png"
    buildSVG graphName courseMap svgFilename True
    createImageFile svgFilename imageFilename
    return (svgFilename, imageFilename)

-- | Creates an image, and returns the name of the svg used to create the
-- image and the name of the image
getTimetableImage :: String -> String -> IO (String, String)
getTimetableImage courses session = do
    gen <- newStdGen
    let (rand, _) = next gen
        svgFilename = show rand ++ ".svg"
        imageFilename = show rand ++ ".png"
    renderTable svgFilename courses session
    createImageFile svgFilename imageFilename
    return (svgFilename, imageFilename)
