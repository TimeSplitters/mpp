<?php
class Media extends MediaCore {
    public static function minifyCSS($css_content, $fileuri = false, &$import_url = array())
    {
        Media::$current_css_file = $fileuri;

        if (strlen($css_content) > 0) {
            $limit  = Media::getBackTrackLimit();
            $css_content = preg_replace('#/\*.*?\*/#s', '', $css_content, $limit);
            $css_content = preg_replace_callback(Media::$pattern_callback, array('Media', 'replaceByAbsoluteURL'), $css_content, $limit);
            //$css_content = preg_replace('#\s+#', ' ', $css_content, $limit);
            $css_content = str_replace(array("\t", "\n", "\r"), '', $css_content);
            $css_content = str_replace(array('; ', ': '), array(';', ':'), $css_content);
            $css_content = str_replace(array(' {', '{ '), '{', $css_content);
            $css_content = str_replace(', ', ',', $css_content);
            $css_content = str_replace(array('} ', ' }', ';}'), '}', $css_content);
            $css_content = str_replace(array(':0px', ':0em', ':0pt', ':0%'), ':0', $css_content);
            $css_content = str_replace(array(' 0px', ' 0em', ' 0pt', ' 0%'), ' 0', $css_content);
            $css_content = str_replace('\'images_ie/', '\'images/', $css_content);
            $css_content = preg_replace_callback('#(AlphaImageLoader\(src=\')([^\']*\',)#s', array('Tools', 'replaceByAbsoluteURL'), $css_content);
            // Store all import url
            preg_match_all('#@(import|charset) .*?;#i', $css_content, $m);
            for ($i = 0, $total = count($m[0]); $i < $total; $i++) {
                if (isset($m[1][$i]) && $m[1][$i] == 'import') {
                    $import_url[] = $m[0][$i];
                }
                $css_content = str_replace($m[0][$i], '', $css_content);
            }

            return trim($css_content);
        }
        return false;
    }
}