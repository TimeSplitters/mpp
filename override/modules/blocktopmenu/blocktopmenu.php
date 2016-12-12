<?php
/*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

//require(dirname(__FILE__).'/menutoplinks.class.php');

class BlocktopmenuOverride extends Blocktopmenu
{
    protected function makeMenu()
    {
        $menu_items = $this->getMenuItems();
        $id_lang = (int)$this->context->language->id;
        $id_shop = (int)Shop::getContextShopID();

        foreach ($menu_items as $item) {
            if (!$item) {
                continue;
            }

            preg_match($this->pattern, $item, $value);
            $id = (int)substr($item, strlen($value[1]), strlen($item));

            switch (substr($item, 0, strlen($value[1]))) {
                case 'CAT':
                    $this->_menu .= $this->generateCategoriesMenu(Category::getNestedCategories($id, $id_lang, false, $this->user_groups));
                    break;

                case 'PRD':
                    $selected = ($this->page_name == 'product' && (Tools::getValue('id_product') == $id)) ? ' class="sfHover"' : '';
                    $product = new Product((int)$id, true, (int)$id_lang);
                    $icon = '';
                    if (!is_null($product->id)) {
                        if($product->id == 8) {
                            $icon = '<span class="icon-book"></span>';
                        } elseif($product->id == 10) {
                            $icon = '<span class="icon-music"></span>';
                        } elseif($product->id == 9) {
                            $icon = '<span class="icon-film"></span>';
                        }
                        $this->_menu .= '<li'.$selected.'>
                        <a href="'.Tools::HtmlEntitiesUTF8($product->getLink()).'" title="'.$product->name.'">
                        '.$icon.'
                        '.$product->name.'
                        </a>
                        </li>'.PHP_EOL;
                    }
                    break;

                case 'CMS':
                    $selected = ($this->page_name == 'cms' && (Tools::getValue('id_cms') == $id)) ? ' class="sfHover"' : '';
                    $cms = CMS::getLinks((int)$id_lang, array($id));
                    if (count($cms)) {
                        $this->_menu .= '<li'.$selected.'><a href="'.Tools::HtmlEntitiesUTF8($cms[0]['link']).'" title="'.Tools::safeOutput($cms[0]['meta_title']).'">'.Tools::safeOutput($cms[0]['meta_title']).'</a></li>'.PHP_EOL;
                    }
                    break;

                case 'CMS_CAT':
                    $category = new CMSCategory((int)$id, (int)$id_lang);
                    if (count($category)) {
                        $this->_menu .= '<li><a href="'.Tools::HtmlEntitiesUTF8($category->getLink()).'" title="'.$category->name.'">'.$category->name.'</a>';
                        $this->getCMSMenuItems($category->id);
                        $this->_menu .= '</li>'.PHP_EOL;
                    }
                    break;

                // Case to handle the option to show all Manufacturers
                case 'ALLMAN':
                    $link = new Link;
                    $this->_menu .= '<li><a href="'.$link->getPageLink('manufacturer').'" title="'.$this->l('All manufacturers').'">'.$this->l('All manufacturers').'</a><ul>'.PHP_EOL;
                    $manufacturers = Manufacturer::getManufacturers();
                    foreach ($manufacturers as $key => $manufacturer) {
                        $this->_menu .= '<li><a href="'.$link->getManufacturerLink((int)$manufacturer['id_manufacturer'], $manufacturer['link_rewrite']).'" title="'.Tools::safeOutput($manufacturer['name']).'">'.Tools::safeOutput($manufacturer['name']).'</a></li>'.PHP_EOL;
                    }
                    $this->_menu .= '</ul>';
                    break;

                case 'MAN':
                    $selected = ($this->page_name == 'manufacturer' && (Tools::getValue('id_manufacturer') == $id)) ? ' class="sfHover"' : '';
                    $manufacturer = new Manufacturer((int)$id, (int)$id_lang);
                    if (!is_null($manufacturer->id)) {
                        if (intval(Configuration::get('PS_REWRITING_SETTINGS'))) {
                            $manufacturer->link_rewrite = Tools::link_rewrite($manufacturer->name);
                        } else {
                            $manufacturer->link_rewrite = 0;
                        }
                        $link = new Link;
                        $this->_menu .= '<li'.$selected.'><a href="'.Tools::HtmlEntitiesUTF8($link->getManufacturerLink((int)$id, $manufacturer->link_rewrite)).'" title="'.Tools::safeOutput($manufacturer->name).'">'.Tools::safeOutput($manufacturer->name).'</a></li>'.PHP_EOL;
                    }
                    break;

                // Case to handle the option to show all Suppliers
                case 'ALLSUP':
                    $link = new Link;
                    $this->_menu .= '<li><a href="'.$link->getPageLink('supplier').'" title="'.$this->l('All suppliers').'">'.$this->l('All suppliers').'</a><ul>'.PHP_EOL;
                    $suppliers = Supplier::getSuppliers();
                    foreach ($suppliers as $key => $supplier) {
                        $this->_menu .= '<li><a href="'.$link->getSupplierLink((int)$supplier['id_supplier'], $supplier['link_rewrite']).'" title="'.Tools::safeOutput($supplier['name']).'">'.Tools::safeOutput($supplier['name']).'</a></li>'.PHP_EOL;
                    }
                    $this->_menu .= '</ul>';
                    break;

                case 'SUP':
                    $selected = ($this->page_name == 'supplier' && (Tools::getValue('id_supplier') == $id)) ? ' class="sfHover"' : '';
                    $supplier = new Supplier((int)$id, (int)$id_lang);
                    if (!is_null($supplier->id)) {
                        $link = new Link;
                        $this->_menu .= '<li'.$selected.'><a href="'.Tools::HtmlEntitiesUTF8($link->getSupplierLink((int)$id, $supplier->link_rewrite)).'" title="'.$supplier->name.'">'.$supplier->name.'</a></li>'.PHP_EOL;
                    }
                    break;

                case 'SHOP':
                    $selected = ($this->page_name == 'index' && ($this->context->shop->id == $id)) ? ' class="sfHover"' : '';
                    $shop = new Shop((int)$id);
                    if (Validate::isLoadedObject($shop)) {
                        $link = new Link;
                        $this->_menu .= '<li'.$selected.'><a href="'.Tools::HtmlEntitiesUTF8($shop->getBaseURL()).'" title="'.$shop->name.'">'.$shop->name.'</a></li>'.PHP_EOL;
                    }
                    break;
                case 'LNK':
                    $link = MenuTopLinks::get((int)$id, (int)$id_lang, (int)$id_shop);
                    if (count($link)) {
                        if (!isset($link[0]['label']) || ($link[0]['label'] == '')) {
                            $default_language = Configuration::get('PS_LANG_DEFAULT');
                            $link = MenuTopLinks::get($link[0]['id_linksmenutop'], $default_language, (int)Shop::getContextShopID());
                        }
                        $this->_menu .= '<li><a href="'.Tools::HtmlEntitiesUTF8($link[0]['link']).'"'.(($link[0]['new_window']) ? ' onclick="return !window.open(this.href);"': '').' title="'.Tools::safeOutput($link[0]['label']).'">'.Tools::safeOutput($link[0]['label']).'</a></li>'.PHP_EOL;
                    }
                    break;
            }
        }
    }
}
