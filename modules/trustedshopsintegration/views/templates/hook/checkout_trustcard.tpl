{*
* 2007-2017 PrestaShop
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
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2017 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<div id="trustedShopsCheckout" style="display: none;">
    <span id="tsCheckoutOrderNr">{$order_number|escape:'htmlall':'UTF-8'}</span>
    <span id="tsCheckoutBuyerEmail">{$customer_email|escape:'htmlall':'UTF-8'}</span>
    <span id="tsCheckoutOrderAmount">{$order_amount|escape:'htmlall':'UTF-8'}</span>
    <span id="tsCheckoutOrderCurrency">{$order_currency|escape:'htmlall':'UTF-8'}</span>
    <span id="tsCheckoutOrderPaymentType">{$payment_method|escape:'htmlall':'UTF-8'}</span>
    <span id="tsCheckoutOrderEstDeliveryDate">{$delivery_date|escape:'htmlall':'UTF-8'}</span>
<!-- product reviews start -->
<!-- for each product in the basket full set of data is required -->
{if $collect_reviews == 1}
    {foreach from=$products key=key item=i}
        <span class="tsCheckoutProductItem">
            <span class="tsCheckoutProductUrl">{$i.url|escape:'htmlall':'UTF-8'}</span>
            <span class="tsCheckoutProductImageUrl">{$i.imageurl|escape:'htmlall':'UTF-8'}</span>
            <span class="tsCheckoutProductName">{$i.product_name|escape:'htmlall':'UTF-8'}</span>
            <span class="tsCheckoutProductSKU">{$i.sku|escape:'htmlall':'UTF-8'}</span>
            <span class="tsCheckoutProductGTIN">{$i.gtin|escape:'htmlall':'UTF-8'}</span>
            <span class="tsCheckoutProductMPN">{$i.mpn|escape:'htmlall':'UTF-8'}</span>
            <span class="tsCheckoutProductBrand">{$i.brand|escape:'htmlall':'UTF-8'}</span>
        </span>
    {/foreach}
{/if}
<!-- product reviews end -->
</div>
