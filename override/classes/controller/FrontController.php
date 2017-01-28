<?php
/**
 * 2007-2016 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author PrestaShop SA <contact@prestashop.com>
 *  @copyright  2007-2016 PrestaShop SA
 *  @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

class FrontController extends FrontControllerCore
{
    /**
     * Compiles and outputs full page content
     *
     * @return bool
     * @throws Exception
     * @throws SmartyException
     */
    public function display()
    {
        Tools::safePostVars();

        // assign css_files and js_files at the very last time
        if ((Configuration::get('PS_CSS_THEME_CACHE') || Configuration::get('PS_JS_THEME_CACHE')) && is_writable(_PS_THEME_DIR_.'cache')) {
            // CSS compressor management
            if (Configuration::get('PS_CSS_THEME_CACHE')) {
                $this->css_files = Media::cccCss($this->css_files);
            }
            //JS compressor management
            if (Configuration::get('PS_JS_THEME_CACHE') && !$this->useMobileTheme()) {
                $this->js_files = Media::cccJs($this->js_files);
            }
        }

        $this->context->smarty->assign(array(
            'css_files'      => $this->css_files,
            'js_files'       => ($this->getLayout() && (bool)Configuration::get('PS_JS_DEFER')) ? array() : $this->js_files,
            'js_defer'       => (bool)Configuration::get('PS_JS_DEFER'),
            'errors'         => $this->errors,
            'display_header' => $this->display_header,
            'display_footer' => $this->display_footer,
        ));

        $layout = $this->getLayout();
        if ($layout) {
            if ($this->template) {
                $template = $this->context->smarty->fetch($this->template);
            } else {
                // For retrocompatibility with 1.4 controller

                ob_start();
                $this->displayContent();
                $template = ob_get_contents();
                ob_clean();
            }
            $this->context->smarty->assign('template', $template);
            $this->smartyOutputContent($layout);
        } else {
            Tools::displayAsDeprecated('layout.tpl is missing in your theme directory');
            if ($this->display_header) {
                $this->smartyOutputContent(_PS_THEME_DIR_.'header.tpl');
            }

            if ($this->template) {
                $this->smartyOutputContent($this->template);
            } else { // For retrocompatibility with 1.4 controller
                $this->displayContent();
            }

            if ($this->display_footer) {
                $this->smartyOutputContent(_PS_THEME_DIR_.'footer.tpl');
            }
        }

        return true;
    }

    /**
     * Specific medias for mobile device.
     * If autoload directory is present in the mobile theme, these files will not be loaded
     */
    public function setMobileMedia()
    {
        $this->addJquery();

        if (!file_exists($this->getThemeDir().'js/autoload/')) {
            $this->addJS(_THEME_MOBILE_JS_DIR_.'jquery.mobile-1.3.0.min.js');
            $this->addJS(_THEME_MOBILE_JS_DIR_.'jqm-docs.js');
            $this->addJS(_PS_JS_DIR_.'tools.js');
            $this->addJS(_THEME_MOBILE_JS_DIR_.'global.js');
            $this->addJqueryPlugin('fancybox');
        }

        if (!file_exists($this->getThemeDir().'css/autoload/')) {
            $this->addCSS(_THEME_MOBILE_CSS_DIR_.'jquery.mobile-1.3.0.min.css', 'all');
            $this->addCSS(_THEME_MOBILE_CSS_DIR_.'jqm-docs.css', 'all');
            $this->addCSS(_THEME_MOBILE_CSS_DIR_.'global.css', 'all');
        }
    }
}
