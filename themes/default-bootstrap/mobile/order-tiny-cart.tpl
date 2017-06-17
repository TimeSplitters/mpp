<div>
    <div>
        <h3 class="text-uppercase">{l s='Cart summary'}</h3>
        <div id="cart_summary"
             class="table {if $PS_STOCK_MANAGEMENT}stock-management-on{else}stock-management-off{/if}">
            <div>
                {assign var='have_non_virtual_products' value=false}
                {foreach $products as $product}
                    {if $product.is_virtual == 0}
                        {assign var='have_non_virtual_products' value=true}
                    {/if}
                    {assign var='productId' value=$product.id_product}
                    {assign var='productAttributeId' value=$product.id_product_attribute}
                    {assign var='quantityDisplayed' value=0}
                    <div id="product_{$product.id_product}_{$product.id_product_attribute}_{if $quantityDisplayed > 0}nocustom{else}0{/if}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}"
                         class="cart_item{if isset($customizedDatas.$productId.$productAttributeId) AND $quantityDisplayed == 0} alternate_item{/if} address_{$product.id_address_delivery|intval} row gutter-10">
                        <div class="cart_product col-xs-4">
                            <img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}"
                                 alt="{$product.name|escape:'html':'UTF-8'}"
                                 class="btn-block"/>
                        </div>
                        <div class="cart_description col-xs-4">
                            {capture name=sep} : {/capture}
                            {capture}{l s=' : '}{/capture}
                            <strong class="text-uppercase product-name">{$product.name|escape:'html':'UTF-8'}</strong><br />
                            {if isset($product.attributes) && $product.attributes}
                                <small>{$product.categoryName}</small>
                            {/if}
                        </div>
                        <div class="cart_total col-xs-4 text-right" data-title="{l s='Total'}">
                            <span class="price"
                                  id="total_product_price_{$product.id_product}_{$product.id_product_attribute}{if $quantityDisplayed > 0}_nocustom{/if}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}">{if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)} {$customizedDatas.$productId.$productAttributeId|@count} {else} {$product.cart_quantity-$quantityDisplayed}{/if}
                                x</span>
                            <span class="price">{displayPrice price=$product.price_with_reduction}</span>
                        </div>
                    </div>
                {/foreach}
            </div>
            <div>
                <div>
                    <div class="order-detail-total-price row gutter-10">
                        <div class="cart_total_subtotal col-xs-8 text-uppercase text-right"><strong>{l s='Subtotal'}</strong></div>
                        <div class="price cart_total_subtotal text-right col-xs-4"
                           id="total_product">{displayPrice price=$total_products_wt}</div>
                    </div>

                    <div class="cart_total_delivery{if $total_shipping_tax_exc <= 0} unvisible{/if} row gutter-10">
                        <div class="cart_total_subtotal col-xs-8 text-uppercase text-right"><strong>{l s='Shipping fees'}</strong></div>
                        <div class="price cart_total_subtotal text-right col-xs-4"
                           id="total_shipping">{displayPrice price=$total_shipping_tax_exc}</div>
                    </div>

                    {if $use_taxes && $show_taxes && $total_tax != 0 }
                        {if $priceDisplay != 0}
                            <div class="cart_total_price row">
                                <div class="col-xs-8 text-uppercase text-right"><strong>{if $display_tax_label}{l s='Total (tax excl.)'}{else}{l s='Total'}{/if}</strong></div>
                                <div class="price text-right col-xs-4"
                                   id="total_price_without_tax">{displayPrice price=$total_price_without_tax}</div>
                            </div>
                        {/if}
                        <div class="cart_total_tax">
                            <div class="text-uppercase text-right">{l s='Tax'}</div>
                            <div class="price text-right" id="total_tax">{displayPrice price=$total_tax}</div>
                        </div>
                    {/if}

                    <div class="cart_total_voucher{if $total_discounts == 0} unvisible{/if} cart_total_subtotal row">
                        <div class="cart_total_subtotal col-xs-8 text-uppercase text-right">
                            <strong>
                            {if $display_tax_label}
                                {if $use_taxes && $priceDisplay == 0}
                                    {l s='Discount Code'}
                                {else}
                                    {l s='Discount Code'}
                                {/if}
                            {else}
                                {l s='Total vouchers'}
                            {/if}
                            {if isset($discounts[0])}
                                {assign var='activeDiscount' value=$discounts[0]}
                            {/if}
                            {if isset($activeDiscount) && $activeDiscount.code != ''}
                                <a href="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}?deleteDiscount={$activeDiscount.id_discount}"
                                   class="delete_voucher" title="{l s='Delete'}">
                                    <i class="icon-remove-sign"></i>
                                </a>
                            {/if}
                            </strong>
                        </div>
                        <div class="price-discount text-right price col-xs-4" id="total_discount">
                            {if $use_taxes && $priceDisplay == 0}
                                {assign var='total_discounts_negative' value=$total_discounts * -1}
                            {else}
                                {assign var='total_discounts_negative' value=$total_discounts_tax_exc * -1}
                            {/if}
                            {displayPrice price=$total_discounts_negative}
                        </div>
                    </div>

                    <div class="cart_total_price row gutter-10" id="total_price_final">
                        <div class="total_price_container col-xs-8 text-uppercase text-right">
                            <strong>{l s='Total'}</strong>
                        </div>
                        {if $use_taxes}
                            <div class="price text-right col-xs-4" id="total_price_container">
                                <span id="total_price">{displayPrice price=$total_price}</span>
                            </div>
                        {else}
                            <div class="price text-right col-xs-4" id="total_price_container">
                                <span id="total_price">{displayPrice price=$total_price_without_tax}</span>
                            </div>
                        {/if}
                        <div class="hookDisplayProductPriceBlock-price hidden">
                            {hook h="displayCartTotalPriceLabel"}
                        </div>
                    </div>
                    <div class="cart_total_price form_discount hidden">
                        <div id="cart_voucher" class="cart_voucher">
                            {if $voucherAllowed}
                                <form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}?step=1{/if}"
                                      method="post" id="voucher">
                                    <div>
                                        <div class="row gutter-10 valign-bottom discount_table{if isset($discount_errors) && count($discount_errors) == 0} unvisible{/if}">
                                            <div class="col-xs-8 col-sm-8" id="discount_input">
                                            {if isset($discounts[0])}
                                                {assign var='activeDiscount' value=$discounts[0]}
                                            {/if}
                                                <input type="text"
                                                       class="discount_name form-control discount_table_cell"
                                                       id="discount_name"
                                                       name="discount_name"
                                                       placeholder="{l s='Code promo?'}"
                                                       value="{if isset($activeDiscount) && $activeDiscount.code}{$activeDiscount.code}{elseif isset($smarty.post.discount_name)}{$smarty.post.discount_name}{/if}"/>

                                                {if isset($activeDiscount) && $activeDiscount.code != ''}
                                                    <a href="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}?deleteDiscount={$activeDiscount.id_discount}"
                                                       class="price_discount_delete" title="{l s='Delete'}">
                                                            <span id="discount_delete_value"
                                                                  class="discount_table_cell"><span></span></span>
                                                    </a>
                                                {/if}
                                            </div>
                                            <div class="col-xs-4 col-sm-4">
                                                <input type="hidden" name="submitDiscount"
                                                       class="discount_table_cell"/>
                                                <button type="submit" name="submitAddDiscount"
                                                        class="discount_table_cell btn btn-default btn-block"><span>{l s='GO!'}</span>
                                                </button>
                                            </div>
                                        </div>
                                        {if isset($discount_errors) && count($discount_errors) > 0}
                                            <span class="discount_error error_message">{$discount_errors[0]}</span>
                                        {/if}
                                    </div>
                                </form>
                                {if $displayVouchers}
                                    <div id="title"
                                       class="title-offers">{l s='Take advantage of our exclusive offers:'}</div>
                                    <div id="display_cart_vouchers">
                                        {foreach $displayVouchers as $voucher}
                                            {if $voucher.code != ''}<span class="voucher_name"
                                                                          data-code="{$voucher.code|escape:'html':'UTF-8'}">{$voucher.code|escape:'html':'UTF-8'}</span> - {/if}{$voucher.name}
                                            <br/>
                                        {/foreach}
                                    </div>
                                {/if}
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="form_button_payment">

    </div>

    <div id="tiny-cart-contact">
        <h3 class="text-uppercase">{l s='Any question?'}</h3>
        {l s='One last question before placing your order? We\'re here for you!'}
        <br/>
        <strong id="contact-phone"><a href="tel:{Configuration::get('PS_SHOP_PHONE')}" class="phone_number">{Configuration::get('PS_SHOP_PHONE')}</a></strong>
        <small>{l s='(cost of a normal call)'}</small>.
        <br />
        {l s='We are at your disposal from Monday to Friday, 9am to 6pm.'}.
    </div>
</div>