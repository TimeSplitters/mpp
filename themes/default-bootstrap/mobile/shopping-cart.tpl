<div class="col-xs-12 col-sm-12">
    {capture name=path}{l s='Your shopping cart'}{/capture}

    {*<h1 id="cart_title" class="page-heading">{l s='Shopping-cart summary'}
        {if !isset($empty) && !$PS_CATALOG_MODE}
            <span class="heading-counter">{l s='Your shopping cart contains:'}
                <span id="summary_products_quantity">{$productNumber} {if $productNumber == 1}{l s='product'}{else}{l s='products'}{/if}</span>
            </span>
        {/if}
    </h1>*}

    {if isset($account_created)}
        <p class="alert alert-success">
            {l s='Your account has been created.'}
        </p>
    {/if}

    {assign var='current_step' value='summary'}
    {*include file="$tpl_dir./order-steps.tpl"*}
    {*include file="$tpl_dir./errors.tpl"*}

    {if isset($smarty.get.step) && $smarty.get.step == 1}
        <div id="order-steps-table">
            {if $logged}
            <div class="text-right">
                <small>{l s='Connecté en tant que %s' sprintf=$cookie->email}</small>
            </div>
            {/if}
            <div id="order-left-steps">
                <h3 class="order-step text-uppercase" data-step-id="1">
                    <span {if !$cookie->endedStep}class="step-active"{/if}>1</span>
                    <button id="addressStepEditButton" class="order-edit-button pull-xs-right"
                            {if $cookie->endedStep > 0}style="display: inline-block"{/if}><span class="icon-edit icon-l"></span></button>
                    {l s='Addresses'}
                    <span {if $cookie->endedStep > 0}class="icon-valid step-valid"{/if}></span>
                </h3>
                <div id="opc_account" class="opc-main-block" {if !$cookie->endedStep}style="display: block"{/if}>
                    {include file="$tpl_dir./mobile/order-address.tpl"}
                </div>
                <div id="addressStepResume" {if $cookie->endedStep >= 1}style="display: block;"{/if}>
                    {if !$logged}
                        <div id="addressResumeLogin">
                            <div class="table-cell">
                                <strong>{l s='Login information'}</strong>
                            </div>
                            <div class="table-cell">
                                <input disabled id="created_mail" type="email"/>
                                <input disabled id="created_passwd" type="password"/>
                            </div>
                        </div>
                    {/if}
                    <div class="table-row" id="addressResumeDelivery">
                        <h3 class="text-uppercase"><span class="icon-truck icon-l"></span> {l s='Delivery address'}</h3>
                        <blockquote class="user_address_blockquote">
                            {foreach from=$addresses key=k item=address}
                                {if $address.id_address == $cart->id_address_delivery}
                                    {$address.lastname} {$address.firstname}
                                    <br />
                                    {$address.address1} {$address.address2}
                                    <br />
                                    {$address.postcode} {$address.city}
                                    <br />{$address.country}
                                    <br />{$address.phone}
                                {/if}
                            {/foreach}
                        </blockquote>
                    </div>
                </div>

                <h3 class="order-step text-uppercase" data-step-id="2">
                    <span {if $cookie->endedStep == 1}class="step-active"{/if}>2</span>
                    <button id="shippingStepEditButton" class="order-edit-button pull-xs-right"
                            {if $cookie->endedStep != 1 && $cookie->endedStep}style="display: inline-block"{/if}><span class="icon-edit icon-l"></span></button>
                    {l s='Your delivery mode'}
                    <span {if $cookie->endedStep > 1}class="icon-valid step-valid"{/if}></span>
                </h3>
                <div id="carrier_area" class="opc-main-block" {if $cookie->endedStep == 1}style="display: block"{/if}>
                    {include file="$tpl_dir./mobile/order-carrier-products.tpl"}
                    {*include file="$tpl_dir./order-carrier.tpl"*}
                </div>

                <h3 class="order-step step-payment text-uppercase" data-step-id="3">
                    <span {if $cookie->endedStep == 2}class="step-active"{/if}>3</span>
                    {l s='Please choose your payment method'}
                    <span></span>
                </h3>

                <div id="order-payment-block" class="opc-main-block"
                     {if $cookie->endedStep == 2}style="display: block"{/if}>
                    {include file="$tpl_dir./mobile/order-payment.tpl"}
                </div>
                <div id="order-tiny-cart">
                    {include file="$tpl_dir./mobile/order-tiny-cart.tpl"}
                </div>
            </div>
        </div>
        {include file="$tpl_dir./mobile/order-reassurance-block.tpl"}
    {elseif isset($empty)}
        {if $cookie->customer_firstname != '' && $cookie->id_customer > 0}
            <h2>{l s='%s, your cart is still empty...' sprintf=$cookie->customer_firstname}</h2>
        {else}
            <h2>{l s='Hi, your cart is still empty...'}</h2>
        {/if}
        {if $logged}
            <div id="border-box-table" class="border-box-alone">
                <div class="border-box">
                    <strong class="border-box-title">{l s='Go, shopping !'}</strong>
                    <p>{l s='What are you waiting for?!'}<br/>
                        {l s='Get inspired by our last trends or take a look at our latest products.'}</p>
                    <a href="{$link->getCategoryLink(61)}"
                       class="button-login button-shopping">{l s='Continue my shopping >'}</a>
                </div>
            </div>
        {else}
            <div id="border-box-table">
                <div class="row gutter-10">
                    <div class="col-xs-6">
                        <h3 class="border-box-title">{l s='Log in'}</h3>
                        <div>{l s='Log in to your account to see your wishlist and to sync your cart on all your devices - mobile phone, notebook and tablet !'}</div>
                        <a href="{$link->getPageLink('authentication')}"
                           class="btn btn-default btn-block">{l s='I log in'}</a>
                    </div>
                    <div class="col-xs-6">
                        <h3 class="border-box-title">{l s='Join Mon Pot Pourri'}</h3>
                        <div>{l s='Create your account within a few clicks only and join the Mon Pot Pourri community. Enjoy special discounts and access your wishlist!'}</div>
                        <a href="{$link->getPageLink('authentication')}"
                           class="btn btn-default btn-block">{l s='I create my account'}</a>
                    </div>
                </div>
                <div class="row gutter-10">
                    <div>
                        <h3 class="border-box-title">{l s='Go, shopping !'}</h3>
                        <div>{l s='What are you waiting for?! Get inspired by our last trends or take a look at our latest products.'}</div>
                        <a href="{$link->getCategoryLink(61)}"
                           class="button-login button-shopping btn btn-default btn-block">{l s='Continue my shopping >'}</a>
                    </div>
                </div>
            </div>
        {/if}
    {elseif $PS_CATALOG_MODE}
        <p class="alert alert-warning">{l s='This store has not accepted your new order.'}</p>
    {else}
        <div class="page-header">
            <h2 class="cart_not_empty_title">{l s='Cart'}</h2>
        </div>
        <div class="saved_stock">{l s='Stock saved for 20 minutes only'}.</div>
        <hr class="full" />
        {*if isset($lastProductAdded) AND $lastProductAdded}
        <div class="cart_last_product">
            <div class="cart_last_product_header">
                <div class="left">{l s='Last product added'}</div>
            </div>
            <a class="cart_last_product_img"
               href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, $lastProductAdded.id_shop)|escape:'html':'UTF-8'}">
                <img src="{$link->getImageLink($lastProductAdded.link_rewrite, $lastProductAdded.id_image, 'home_default')|escape:'html':'UTF-8'}"
                     alt="{$lastProductAdded.name|escape:'html':'UTF-8'}"/>
            </a>
            <div class="cart_last_product_content">
                <p class="product-name">
                    <a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
                        {$lastProductAdded.name|escape:'html':'UTF-8'}
                    </a>
                </p>
                {if isset($lastProductAdded.attributes) && $lastProductAdded.attributes}
                    <small>
                        <a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
                            {$lastProductAdded.attributes|escape:'html':'UTF-8'}
                        </a>
                    </small>
                {/if}
            </div>
        </div>
        {/if*}
        {assign var='total_discounts_num' value="{if $total_discounts != 0}1{else}0{/if}"}
        {assign var='use_show_taxes' value="{if $use_taxes && $show_taxes}2{else}0{/if}"}
        {assign var='total_wrapping_taxes_num' value="{if $total_wrapping != 0}1{else}0{/if}"}
        {* eu-legal *}
        {hook h="displayBeforeShoppingCartBlock"}
        <div id="order-detail-content">
            <div>
                <div id="cart_summary"
                     class="table {if $PS_STOCK_MANAGEMENT}stock-management-on{else}stock-management-off{/if}">
                    {assign var='have_non_virtual_products' value=false}
                    {foreach $products as $product}
                        {if $product.is_virtual == 0}
                            {assign var='have_non_virtual_products' value=true}
                        {/if}
                        {assign var='productId' value=$product.id_product}
                        {assign var='productAttributeId' value=$product.id_product_attribute}
                        {assign var='quantityDisplayed' value=0}
                        {assign var='ignoreProductLast' value=isset($customizedDatas.$productId.$productAttributeId) || count($gift_products)}
                        {* Display the product line *}
                        {include file="$tpl_dir./mobile/shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}
                        {* Then the customized datas ones*}
                        {if isset($customizedDatas.$productId.$productAttributeId)}
                            {foreach $customizedDatas.$productId.$productAttributeId[$product.id_address_delivery] as $id_customization=>$customization}
                                <div
                                        id="product_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                                        class="product_customization_for_{$product.id_product}_{$product.id_product_attribute}_{$product.id_address_delivery|intval} customization alternate_item {if $product@last && $customization@last && !count($gift_products)}last_item{/if}">
                                    <div class="col-xs-4 col-sm-4">
                                        {foreach $customization.datas as $type => $custom_data}
                                            {if $type == $CUSTOMIZE_FILE}
                                                <div class="customizationUploaded">
                                                    <ul class="customizationUploaded">
                                                        {foreach $custom_data as $picture}
                                                            <li><img src="{$pic_dir}{$picture.value}_small" alt=""
                                                                     class="customizationUploaded"/></li>
                                                        {/foreach}
                                                    </ul>
                                                </div>
                                            {elseif $type == $CUSTOMIZE_TEXTFIELD}
                                                <ul class="typedText">
                                                    {foreach $custom_data as $textField}
                                                        <li>
                                                            {if $textField.name}
                                                                {$textField.name}
                                                            {else}
                                                                {l s='Text #'}{$textField@index+1}
                                                            {/if}
                                                            : {$textField.value}
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            {/if}
                                        {/foreach}
                                    </div>
                                    <div class="cart_quantity col-xs-1 col-sm-1">
                                        {if isset($cannotModify) AND $cannotModify == 1}
                                            <span>{if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)}{$customizedDatas.$productId.$productAttributeId|@count}{else}{$product.cart_quantity-$quantityDisplayed}{/if}</span>
                                        {else}
                                            <input type="hidden" value="{$customization.quantity}"
                                                   name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}_hidden"/>
                                            <input type="text" value="{$customization.quantity}"
                                                   class="cart_quantity_input form-control grey"
                                                   name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"/>
                                            <div class="cart_quantity_button clearfix">
                                                {if $product.minimal_quantity < ($customization.quantity -$quantityDisplayed) OR $product.minimal_quantity <= 1}
                                                    <a
                                                            id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                                                            class="cart_quantity_down btn btn-default button-minus"
                                                            href="{$link->getPageLink('cart', true, NULL, "add=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery}&amp;id_customization={$id_customization}&amp;op=down&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
                                                            rel="nofollow"
                                                            title="{l s='Subtract'}">
                                                        <span><i class="icon-minus"></i></span>
                                                    </a>
                                                {else}
                                                    <a
                                                            id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}"
                                                            class="cart_quantity_down btn btn-default button-minus disabled"
                                                            href="#"
                                                            title="{l s='Subtract'}">
                                                        <span><i class="icon-minus"></i></span>
                                                    </a>
                                                {/if}
                                                <a
                                                        id="cart_quantity_up_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                                                        class="cart_quantity_up btn btn-default button-plus"
                                                        href="{$link->getPageLink('cart', true, NULL, "add=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery}&amp;id_customization={$id_customization}&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
                                                        rel="nofollow"
                                                        title="{l s='Add'}">
                                                    <span><i class="icon-plus"></i></span>
                                                </a>
                                            </div>
                                        {/if}
                                    </div>
                                    <div class="cart_delete text-center col-xs-3">
                                        {if isset($cannotModify) AND $cannotModify == 1}
                                        {else}
                                            <a
                                                    id="{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                                                    class="cart_quantity_delete"
                                                    href="{$link->getPageLink('cart', true, NULL, "delete=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization={$id_customization}&amp;id_address_delivery={$product.id_address_delivery}&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
                                                    rel="nofollow"
                                                    title="{l s='Delete'}">
                                                <i class="icon-trash"></i>
                                            </a>
                                        {/if}
                                    </div>
                                </div>
                                {assign var='quantityDisplayed' value=$quantityDisplayed+$customization.quantity}
                            {/foreach}

                            {* If it exists also some uncustomized products *}
                            {if $product.quantity-$quantityDisplayed > 0}{include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}{/if}
                        {/if}
                    {/foreach}
                    {foreach $gift_products as $product}
                        {assign var='productId' value=$product.id_product}
                        {assign var='productAttributeId' value=$product.id_product_attribute}
                        {assign var='quantityDisplayed' value=0}
                        {assign var='ignoreProductLast' value=isset($customizedDatas.$productId.$productAttributeId)}
                        {assign var='cannotModify' value=1}
                        {* Display the gift product line *}
                        {include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}
                    {/foreach}
                </div>
                <div id="order-detail-footer">
                    {if $use_taxes}
                        {if $priceDisplay}
                            <div id="discount_code_block" class="cart_total_price">
                                <div id="cart_voucher" class="cart_voucher">
                                    {if $voucherAllowed}
                                        {if isset($errors_discount) && $errors_discount}
                                            <ul class="alert alert-danger">
                                                {foreach $errors_discount as $k=>$error}
                                                    <li>{$error|escape:'html':'UTF-8'}</li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                        <form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}"
                                              method="post" id="voucher">
                                            <fieldset>
                                                <h4>{l s='Vouchers'}</h4>
                                                <input type="text" class="discount_name form-control" id="discount_name"
                                                       name="discount_name"
                                                       value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}"/>
                                                <input type="hidden" name="submitDiscount"/>
                                                <button type="submit" name="submitAddDiscount"
                                                        class="btn btn-default"><span>{l s='OK'}</span>
                                                </button>
                                            </fieldset>
                                        </form>
                                        {if isset($errors_discount) && $errors_discount}
                                            <ul class="alert alert-danger">
                                                {foreach $errors_discount as $k=>$error}
                                                    <li>{$error|escape:'html':'UTF-8'}</li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                        {if $displayVouchers}
                                            <p id="title"
                                               class="title-offers">{l s='Take advantage of our exclusive offers:'}</p>
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
                        {else}
                            {*
                            HERE WE GO
                            *}
                            <div class="cart_total_price form_discount">
                                <div id="cart_voucher" class="cart_voucher">
                                    {if $voucherAllowed}
                                        {if isset($errors_discount) && $errors_discount}
                                            <ul class="alert alert-danger">
                                                {foreach $errors_discount as $k=>$error}
                                                    <li>{$error|escape:'html':'UTF-8'}</li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                        <form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}"
                                              method="post" id="voucher">
                                            <div>
                                                <div class="row gutter-10 valign-middle">
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

                                                        {if isset($activeDiscount) && $activeDiscount.code != '' || isset($smarty.post.discount_name)}
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
                                                                class="btn btn-default btn-block">
                                                            <span>{l s='GO!'}</span>
                                                        </button>
                                                        {if isset($discount_errors) && count($discount_errors) == 0 && isset($activeDiscount) && $activeDiscount.code != ''}
                                                            <span class="discount_success"></span>
                                                        {/if}
                                                    </div>
                                                </div>
                                                <div class="discount_table_row row gutter-10">
                                                    <div class="discount_table_cell">
                                                        {if isset($discount_errors) && count($discount_errors) > 0}<span
                                                                class="discount_error error_message">{l s='Discount code incorrect'}</span>{/if}
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row gutter-10 hidden">{l s='Is this your first order? Enter WELCOME for an immediate 15$ discount.'}</div>
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
                        {/if}
                    {else}
                        <div class="cart_total_price">
                            <div id="cart_voucher" class="cart_voucher">
                                {if $voucherAllowed}
                                    {if isset($errors_discount) && $errors_discount}
                                        <ul class="alert alert-danger">
                                            {foreach $errors_discount as $k=>$error}
                                                <li>{$error|escape:'html':'UTF-8'}</li>
                                            {/foreach}
                                        </ul>
                                    {/if}
                                    <form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}"
                                          method="post" id="voucher">
                                        <fieldset>
                                            <h4>{l s='Vouchers'}</h4>
                                            <input type="text" class="discount_name form-control" id="discount_name"
                                                   name="discount_name"
                                                   value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}"/>
                                            <input type="hidden" name="submitDiscount"/>
                                            <button type="submit" name="submitAddDiscount"
                                                    class="button btn btn-default button-small">
                                                <span>{l s='OK'}</span>
                                            </button>
                                        </fieldset>
                                    </form>
                                    {if $displayVouchers}
                                        <p id="title"
                                           class="title-offers">{l s='Take advantage of our exclusive offers:'}</p>
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
                            <p class="text-right">{l s='Total products'}</p>
                            <p class="price" id="total_product">{displayPrice price=$total_products}</p>
                        </div>
                    {/if}
                    <div class="table-total-group text-right">
                        <div{if $total_wrapping == 0} style="display: none;"{/if}>
                            <div>
                                {if $use_taxes}
                                    {if $display_tax_label}{l s='Total gift wrapping (tax incl.)'}{else}{l s='Total gift-wrapping cost'}{/if}
                                {else}
                                    {l s='Total gift-wrapping cost'}
                                {/if}
                            </div>
                            <p class="price-discount price" id="total_wrapping">
                                {if $use_taxes}
                                    {if $priceDisplay}
                                        {displayPrice price=$total_wrapping_tax_exc}
                                    {else}
                                        {displayPrice price=$total_wrapping}
                                    {/if}
                                {else}
                                    {displayPrice price=$total_wrapping_tax_exc}
                                {/if}
                            </p>
                        </div>

                        <div class="order-detail-total-price row gutter-10">
                            <div class="cart_total_subtotal col-xs-8 col-sm-8 text-uppercase">
                                <span>{l s='Subtotal'}</span>
                            </div>
                            <div class="price cart_total_subtotal col-xs-4 col-sm-4"
                                 id="total_product">{displayPrice price=$total_products_wt}</div>
                        </div>
                        <div class="cart_total_delivery{if $total_shipping_tax_exc <= 0} unvisible{/if} row gutter-10">
                            <div class="cart_total_subtotal col-xs-8 col-sm-8 text-uppercase">
                                <span>{l s='Shipping fees'}</span>
                            </div>
                            <div class="price cart_total_subtotal col-xs-4 col-sm-4"
                                 id="total_shipping">{displayPrice price=$total_shipping_tax_exc}</div>
                        </div>
                        <div class="cart_total_voucher{if $total_discounts == 0} unvisible{/if} cart_total_subtotal row gutter-10">
                            <div class="cart_total_subtotal col-xs-8 col-sm-8 text-uppercase">
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
                                </strong>
                            </div>
                            <div class="price-discount price col-xs-4 col-sm-4" id="total_discount">
                                {if $use_taxes && $priceDisplay == 0}
                                    {assign var='total_discounts_negative' value=$total_discounts * -1}
                                {else}
                                    {assign var='total_discounts_negative' value=$total_discounts_tax_exc * -1}
                                {/if}
                                {displayPrice price=$total_discounts_negative}
                            </div>
                        </div>
                        {if $use_taxes && $show_taxes && $total_tax != 0 }
                            {if $priceDisplay != 0}
                                <div class="row gutter-10">
                                    <div class="cart_total_price col-xs-8 col-sm-8 text-uppercase">
                                        <strong>{if $display_tax_label}{l s='Total (tax excl.)'}{else}{l s='Total'}{/if}</strong>
                                    </div>
                                    <div class="price col-xs-4 col-sm-4"
                                         id="total_price_without_tax">{displayPrice price=$total_price_without_tax}</div>
                                </div>
                            {/if}
                            <div class="row gutter-10">
                                <div class="cart_total_tax col-xs-8 col-sm-8 text-uppercase">
                                    <strong>{l s='Tax'}</strong>
                                </div>
                                <div class="price col-xs-4 col-sm-4"
                                     id="total_tax">{displayPrice price=$total_tax}</div>
                            </div>
                        {/if}
                        <hr class="full" />
                        <div class="cart_total_price row gutter-10" id="total_price_final">
                            <div class="total_price_container col-xs-8 col-sm-8 text-uppercase">
                                <strong>{l s='Total'}</strong>
                            </div>
                            {if $use_taxes}
                                <div class="price col-xs-4 col-sm-4" id="total_price_container">
                                    <strong id="total_price">{displayPrice price=$total_price}</strong>
                                </div>
                            {else}
                                <div class="price col-xs-4 col-sm-4" id="total_price_container">
                                    <strong id="total_price">{displayPrice price=$total_price_without_tax}</strong>
                                </div>
                            {/if}
                            <div class="hookDisplayProductPriceBlock-price unvisible">
                                {hook h="displayCartTotalPriceLabel"}
                            </div>
                        </div>
                        <div>
                            <div class="total_prix_constate_save success_message">{l s='I save'} <span
                                        id="total_prix_constate_save">{displayPrice price=($total_prix_constate-$total_products_wt)}</span>.<br />
                                <span id="total_prix_constate_percent_save">{((($total_prix_constate-$total_products_wt)/$total_prix_constate)*100)|string_format:"%.0f"}
                                    %</span> {l s='cheaper than in shops'}.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {if !$logged}
            <div id="order_block_login">
                <div id="secured_payment_logos">
                    <img src="{$img_dir}/Moyens-Paiement.jpg" alt="Icônes Paiements" class="btn-block" />
                    <div class="text-center">
                        <span class="icon-lock"></span> {l s='Secured authentication and payment'}
                    </div>
                </div>
                <div>
                    <br />
                {if isset($back)}<input type="hidden" class="hidden" name="back"
                                        value="{$back|escape:'html':'UTF-8'}" />{/if}
                {if isset($pid)}<input type="hidden" class="hidden" name="pid"
                                       value="{$pid|escape:'html':'UTF-8'}" />{/if}
                <a href="{$link->getPageLink('order')}?step=1&content_only=1" class="btn btn-primary btn-block">{l s='Passer commande'}</a>
                </div>
            </div>
            {/if}
        </div>
        {if $logged}
            <div class="order_payment_button">
                <br />
                <a href="?step=1&content_only=1" class="btn btn-primary btn-block order_block_payment_button">{l s='Passer commande'}</a>
            </div>
        {/if}
        <!-- end order-detail-content -->
        {*include file="$tpl_dir./mobile/order-reassurance-block.tpl"*}
        {if $show_option_allow_separate_package}
            <p>
                <label for="allow_seperated_package" class="checkbox inline">
                    <input type="checkbox" name="allow_seperated_package" id="allow_seperated_package"
                           {if $cart->allow_seperated_package}checked="checked"{/if} autocomplete="off"/>
                    {l s='Send available products first'}
                </label>
            </p>
        {/if}

        {* Define the style if it doesn't exist in the PrestaShop version*}
        {* Will be deleted for 1.5 version and more *}
        {if !isset($addresses_style)}
            {$addresses_style.company = 'address_company'}
            {$addresses_style.vat_number = 'address_company'}
            {$addresses_style.firstname = 'address_name'}
            {$addresses_style.lastname = 'address_name'}
            {$addresses_style.address1 = 'address_address1'}
            {$addresses_style.address2 = 'address_address2'}
            {$addresses_style.city = 'address_city'}
            {$addresses_style.country = 'address_country'}
            {$addresses_style.phone = 'address_phone'}
            {$addresses_style.phone_mobile = 'address_phone_mobile'}
            {$addresses_style.alias = 'address_title'}
        {/if}
        {strip}
            {addJsDef deliveryAddress=$cart->id_address_delivery|intval}
            {addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
            {addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}
        {/strip}
    {/if}

    {if isset($order_see_also)}
        <section class="carrousel">
            <h3>{l s="We thought you'd also love..."}</h3>
            <div class="carrousel">
                {include file="./product-list.tpl" products=$order_see_also nb_products_per_line=4 isCarrousel=true}
            </div>
        </section>
    {/if}

    {if isset($waiting_wishlist)}
        <section class="carrousel">
            <h3>{l s="Your favorite products are waiting for you..."}</h3>
            <div class="carrousel">
                {include file="./product-list.tpl" products=$waiting_wishlist nb_products_per_line=4 isCarrousel=true}
            </div>
        </section>
    {/if}
</div>