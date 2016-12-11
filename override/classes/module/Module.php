<?php
/*
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

abstract class Module extends ModuleCore
{
    /*
    ** Template management (display, overload, cache)
    */
    protected static function _isTemplateOverloadedStatic($module_name, $template)
    {
        if (!Context::getContext()->isMobile()) {
            $theme_dir = _PS_THEME_DIR_;
        } else {
            $theme_dir = _PS_THEME_MOBILE_DIR_;
        }

        if (Tools::file_exists_cache($theme_dir.'modules/'.$module_name.'/'.$template)) {
            return $theme_dir.'modules/'.$module_name.'/'.$template;
        } elseif (Tools::file_exists_cache($theme_dir.'modules/'.$module_name.'/views/templates/hook/'.$template)) {
            return $theme_dir.'modules/'.$module_name.'/views/templates/hook/'.$template;
        } elseif (Tools::file_exists_cache($theme_dir.'modules/'.$module_name.'/views/templates/front/'.$template)) {
            return $theme_dir.'modules/'.$module_name.'/views/templates/front/'.$template;
        } elseif (Tools::file_exists_cache(_PS_MODULE_DIR_.$module_name.'/views/templates/hook/'.$template)) {
            return false;
        } elseif (Tools::file_exists_cache(_PS_MODULE_DIR_.$module_name.'/views/templates/front/'.$template)) {
            return false;
        } elseif (Tools::file_exists_cache(_PS_MODULE_DIR_.$module_name.'/'.$template)) {
            return false;
        }
        return null;
    }
}