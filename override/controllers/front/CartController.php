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

class CartController extends CartControllerCore
{
    public function postProcess()
    {
        // Update the cart ONLY if $this->cookies are available, in order to avoid ghost carts created by bots
        if ($this->context->cookie->exists() && !$this->errors && $this->isTokenValid()) {
            // Mode sélection livre
            if (Tools::getValue('product_choice') == 'livre') {
                $this->context->cookie->product_choice_livre_titre = Tools::getValue('book_name');
            } else {
                // Mode Surprise
                if (Tools::getValue('id_product') == 8) {
                    // BOOK
                    if (Tools::getValue('gender') != ""
                        && Tools::getValue('age_range') != ""
                        && Tools::getValue('genre') != ""
                        && Tools::getValue('soumission_choix') != ""
                        && Tools::getValue('description_attentes') != ""
                        && Tools::getValue('description_genre') != ""
                    ) {
                        shell_exec('curl https://docs.google.com/forms/d/1f1pnGS129_DsTeN_TIUMyJNXARfHmpHp-QQLO-Yhf2g/formResponse\?ifq\&entry.773488609\='
                            . rawurlencode(Tools::getValue('gender')) .
                            '\&entry.357607404\=' . rawurlencode(Tools::getValue('age_range')) .
                            '\&entry.1289552786\=' . rawurlencode(Tools::getValue('genre')) .
                            '\&entry.1795259749\=' . rawurlencode(Tools::getValue('description_attentes')) .
                            '\&entry.425196228\=' . rawurlencode(Tools::getValue('description_genre')) .
                            '\&entry.1759291032\=' . rawurlencode(Tools::getValue('soumission_choix')) .
                            '\&submit=Submit');

                        $product_choice_book_surprise = array(
                            'gender' => (Tools::getValue('gender')),
                            'age_range' => (Tools::getValue('age_range')),
                            'genre' => (Tools::getValue('genre')),
                            'description_attentes' => (Tools::getValue('description_attentes')),
                            'description_genre' => (Tools::getValue('description_genre')),
                            'soumission_choix' => (Tools::getValue('soumission_choix'))
                        );

                        $this->context->cookie->product_choice_book_surprise = json_encode($product_choice_book_surprise);
                    }
                } elseif (Tools::getValue('id_product') == 9) {
                    // FILM
                    if (Tools::getValue('gender') != ""
                        && Tools::getValue('age_range') != ""
                        && Tools::getValue('genre') != ""
                        && Tools::getValue('year') != ""
                        && Tools::getValue('origin') != ""
                        && Tools::getValue('description_attentes') != ""
                        && Tools::getValue('description_genre') != ""
                        && Tools::getValue('soumission_choix') != ""
                    ) {
                        shell_exec('curl https://docs.google.com/forms/d/1gx2M_Kk-F_Sioqvkwges49IgYbE6VGWdlzrMRjSyA24/formResponse\?ifq\&entry.273801023\='
                            . rawurlencode(Tools::getValue('gender')) .
                            '\&entry.36037052\=' . rawurlencode(Tools::getValue('age_range')) .
                            '\&entry.1367152334\=' . rawurlencode(Tools::getValue('genre')) .
                            '\&entry.2001711735\=' . rawurlencode(Tools::getValue('year')) .
                            '\&entry.1566312560\=' . rawurlencode(Tools::getValue('origin')) .
                            '\&entry.1744868556\=' . rawurlencode(Tools::getValue('description_attentes')) .
                            '\&entry.1582820680\=' . rawurlencode(Tools::getValue('description_genre')) .
                            '\&entry.1854191893\=' . rawurlencode(Tools::getValue('soumission_choix')) .
                            '\&submit=Submit');

                        /*$sql = 'UPDATE '._DB_PREFIX_.'customer c
                                SET c.order_confirmation_response = "'.Tools::getValue('sondageReponse').'"
                                WHERE c.id_customer = '.(int)$this->context->customer->id;
                        Db::getInstance()->execute($sql);*/
                    }
                } elseif (Tools::getValue('id_product') == 10) {
                    // MUSIC
                    if (
                        Tools::getValue('gender') != ""
                        && Tools::getValue('age_range') != ""
                        && Tools::getValue('genre') != ""
                        && Tools::getValue('description_attentes') != ""
                        && Tools::getValue('year') != ""
                        && Tools::getValue('genre_connu') != ""
                        && Tools::getValue('soumission_choix') != ""
                    ) {
                        shell_exec('curl https://docs.google.com/forms/d/1hHIED9jYDf_UwUXVslLzhCDLuEVVjA3wtUluJLqCKyo/formResponse\?ifq\&entry.273801023\='
                            . rawurlencode(Tools::getValue('gender')) .
                            '\&entry.36037052\=' . rawurlencode(Tools::getValue('age_range')) .
                            '\&entry.1367152334\=' . rawurlencode(Tools::getValue('genre')) .
                            '\&entry.1744868556\=' . rawurlencode(Tools::getValue('description_attentes')) .
                            '\&entry.2001711735\=' . rawurlencode(Tools::getValue('year')) .
                            '\&entry.1582820680\=' . rawurlencode(Tools::getValue('genre_connu')) .
                            '\&entry.2141262967\=' . rawurlencode(Tools::getValue('soumission_choix')) .
                            '\&submit=Submit');

                        /*$sql = 'UPDATE '._DB_PREFIX_.'customer c
                                SET c.order_confirmation_response = "'.Tools::getValue('sondageReponse').'"
                                WHERE c.id_customer = '.(int)$this->context->customer->id;
                        Db::getInstance()->execute($sql);*/
                    }
                }
            }

            if (Tools::getIsset('add') || Tools::getIsset('update')) {
                $this->processChangeProductInCart();
            } elseif (Tools::getIsset('delete')) {
                $this->processDeleteProductInCart();
            } elseif (Tools::getIsset('changeAddressDelivery')) {
                $this->processChangeProductAddressDelivery();
            } elseif (Tools::getIsset('allowSeperatedPackage')) {
                $this->processAllowSeperatedPackage();
            } elseif (Tools::getIsset('duplicate')) {
                $this->processDuplicateProduct();
            }
            // Make redirection
            if (!$this->errors && !$this->ajax) {
                $queryString = Tools::safeOutput(Tools::getValue('query', null));
                if ($queryString && !Configuration::get('PS_CART_REDIRECT')) {
                    Tools::redirect('index.php?controller=search&search=' . $queryString);
                }

                // Redirect to previous page
                if (isset($_SERVER['HTTP_REFERER'])) {
                    preg_match('!http(s?)://(.*)/(.*)!', $_SERVER['HTTP_REFERER'], $regs);
                    if (isset($regs[3]) && !Configuration::get('PS_CART_REDIRECT')) {
                        $url = preg_replace('/(\?)+content_only=1/', '', $_SERVER['HTTP_REFERER']);
                        Tools::redirect($url);
                    }
                }

                Tools::redirect('index.php?controller=order&' . (isset($this->id_product) ? 'ipa=' . $this->id_product : ''));
            }
        } elseif (!$this->isTokenValid()) {
            if (Tools::getValue('ajax')) {
                $this->ajaxDie(Tools::jsonEncode(array(
                    'hasError' => true,
                    'errors' => array(Tools::displayError('Impossible to add the product to the cart. Please refresh page.')),
                )));
            } else {
                Tools::redirect('index.php');
            }
        }
    }
}
