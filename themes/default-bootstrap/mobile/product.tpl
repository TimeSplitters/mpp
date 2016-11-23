{if $errors|@count == 0}
    {if !isset($priceDisplayPrecision)}
        {assign var='priceDisplayPrecision' value=2}
    {/if}
    {if !$priceDisplay || $priceDisplay == 2}
        {assign var='productPrice' value=$the_product->getPrice(true, $the_combination_id, 6)}
        {assign var='productPriceWithoutReduction' value=$the_product->getPriceWithoutReduct(false, $smarty.const.NULL)}
    {elseif $priceDisplay == 1}
        {assign var='productPrice' value=$the_product->getPrice(false, $the_combination_id, 6)}
        {assign var='productPriceWithoutReduction' value=$the_product->getPriceWithoutReduct(true, $smarty.const.NULL)}
    {/if}
    <div itemscope itemtype="https://schema.org/Product">
        <meta itemprop="url" content="{$link->getProductLink($the_product)}">
        {*<p class="hidden"
           id="added_to_wishlist">{l s='This product has been added to your Wishlist. Find it at any time in you customer area.'}</p>*}


        {if isset($confirmation) && $confirmation}
            <p class="confirmation">
                {$confirmation}
            </p>
        {/if}

        {foreach from=$features item=feature}
            {if $feature.id_feature == 12}
                {assign var='product_old_price' value=$feature.value}
            {elseif $feature.id_feature == 13}
                {assign var='product_collection_name' value=$feature.value}
            {/if}
        {/foreach}

        <div id="product_infos_firstgroup" class="text-xs-center">
            <h1 id="h1_product"
                class="text-uppercase">{$product_collection_name|escape:'html':'UTF-8'}</h1>
            <span itemprop="name" class="text-uppercase">
                <span id="product_main_category">{$theCategory}</span>, <span id="product_main_caracteristics">{if isset($the_combination['attributes_values'][22])}{$the_combination['attributes_values'][22]|escape:'html':'UTF-8'} {/if}</span>
            </span>
            {if $nbComments > 0}
                <div id="product_ratings">
                    <div class="comments_note" itemprop="aggregateRating" itemscope
                         itemtype="https://schema.org/AggregateRating">
                        <div class="star_content">
                            <a href="#product_comments_block_tab">
                                {section name="i" start=0 loop=5 step=1}
                                    {if $averageTotal le $smarty.section.i.index}
                                        <span class="rating-star"></span>
                                    {else}
                                        <span class="rating-star-o"></span>
                                    {/if}
                                {/section}
                                <meta itemprop="worstRating" content="0"/>
                                <meta itemprop="ratingValue"
                                      content="{$averageTotal|round:1|escape:'html':'UTF-8'}"/>
                                <meta itemprop="bestRating" content="5"/>
                                <span class="nb-comments"><span
                                            itemprop="reviewCount">
                                                                    ({$nbComments})</span></span>
                            </a>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
        <div class="text-xs-center">
            <div id="zoomImg">
                <div id="closeZoom" class="btn btn-default">{l s='Fermer'}</div>
                <button class="zoom-in btn btn-default hidden">+</button>
                <button class="zoom-out btn btn-default hidden">-</button>
            </div>
            <div id="image-block" class="carousel slide">
                <div class="carousel-inner" role="listbox">
                    {assign var=activeItem value=true}
                    {foreach from=$images item=image name=thumbnails}
                        {assign var=imageIds value="`$the_product->id`-`$image.id_image`"}
                        {if !empty($image.legend)}
                            {assign var=imageTitle value=$image.legend|escape:'html':'UTF-8'}
                        {else}
                            {assign var=imageTitle value=$the_product->name|escape:'html':'UTF-8'}
                        {/if}
                        <div class="img-item {if !$image.id_image|@in_array:$combinationImagesIds} unvisible{else} carousel-item{if $activeItem} active{assign var=activeItem value=false}{/if}{/if}"
                             id="thumbnail_{$image.id_image}">
                            <img src="{$image.path}" alt="{$imageTitle}" class="img-fluid"
                                 id="thumb_{$image.id_image}"/>
                        </div>
                    {/foreach}
                </div>
                <ol class="carousel-indicators">
                    {assign var=activeItem value=true}
                    {foreach from=$images item=image name=thumbnails}
                        {assign var=imageIds value="`$the_product->id`-`$image.id_image`"}
                        {if !empty($image.legend)}
                            {assign var=imageTitle value=$image.legend|escape:'html':'UTF-8'}
                        {else}
                            {assign var=imageTitle value=$the_product->name|escape:'html':'UTF-8'}
                        {/if}
                        <li data-target="#image-block" data-img-id="{$image.id_image}"
                            data-slide-to="{$smarty.foreach.thumbnails.index}" class="{if !$image.id_image|@in_array:$combinationImagesIds} unvisible{else}{if $activeItem} active{assign var=activeItem value=false}{/if}{/if}"></li>
                    {/foreach}
                </ol>
            </div> <!-- end carousel -->
            <!-- PRICE -->
            <div class="content_prices clearfix">
                {if $the_product->show_price && !$PS_CATALOG_MODE}
                <!-- prices -->
                <p id="old_price" class="text-uppercase">
                    {l s='Typical price'}
                    <span id="product_typical_price" class="old_price_display">{if isset($the_combination['attributes_values'][24])}{convertPrice price=$the_combination['attributes_values'][24]}{/if}</span>
                    <meta itemprop="priceCurrency"
                          content="{$currency->iso_code}"/>
                </p>
                <p class="our_price_display" itemprop="offers" itemscope
                   itemtype="https://schema.org/Offer">
                    {strip}
                        {if $the_product->quantity > 0}
                            <link itemprop="availability"
                                  href="https://schema.org/InStock"/>
                        {/if}
                        {if $priceDisplay >= 0 && $priceDisplay <= 2}
                            <span id="our_price_display" class="price" itemprop="price"
                                  content="{$productPrice}">{convertPrice price=$productPrice|floatval}</span>
                            {if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
                                {*if $priceDisplay == 1} {l s='tax excl.'}{else} {l s='tax incl.'}{/if*}
                            {/if}
                            <meta itemprop="priceCurrency"
                                  content="{$currency->iso_code}"/>
                            {hook h="displayProductPriceBlock" product=$the_product type="price"}
                        {/if}
                    {/strip}</p>

                {if $priceDisplay == 2}
                    <br/>
                    <span id="pretaxe_price">{strip}<span
                                id="pretaxe_price_display">{convertPrice price=$the_product->getPrice(false, $smarty.const.NULL)}</span>{l s='tax excl.'}{/strip}</span>
                {/if}
            </div>
            <!-- end prices -->
            {if $packItems|@count && $productPrice < $the_product->getNoPackPrice()}
                <p class="pack_price">{l s='Instead of'} <span
                            style="text-decoration: line-through;">{convertPrice price=$the_product->getNoPackPrice()}</span>
                </p>
            {/if}
            {if $the_product->ecotax != 0}
                <p class="price-ecotax">{l s='Including'} <span
                            id="ecotax_price_display">{if $priceDisplay == 2}{$ecotax_tax_exc|convertAndFormatPrice}{else}{$ecotax_tax_inc|convertAndFormatPrice}{/if}</span> {l s='for ecotax'}
                    {if $the_product->specificPrice && $the_product->specificPrice.reduction}
                        <br/>
                        {l s='(not impacted by the discount)'}
                    {/if}
                </p>
            {/if}
            {if !empty($the_product->unity) && $the_product->unit_price_ratio > 0.000000}
                {math equation="pprice / punit_price" pprice=$productPrice  punit_price=$the_product->unit_price_ratio assign=unit_price}
                <p class="unit-price"><span
                            id="unit_price_display">{convertPrice price=$unit_price}</span> {l s='per'} {$the_product->unity|escape:'html':'UTF-8'}
                </p>
                {hook h="displayProductPriceBlock" product=$the_product type="unit_price"}
            {/if}
            {/if} {*close if for show price*}
            {hook h="displayProductPriceBlock" product=$the_product type="weight" hook_origin='product_sheet'}
            {hook h="displayProductPriceBlock" product=$the_product type="after_price"}
            <!-- /PRICE -->
            <!-- EXPRESS -->

            <p>
                {if isset($the_combination['attributes_values'][44])}
                    {assign var=force_express value=$the_combination['attributes_values'][44]}
                {else}
                    {assign var=force_express value=''}
                {/if}
                {assign var=combinationExpress value=0}
                {if (Product::getRealQuantity($the_product->id, $the_combination_id) >= 1 || $force_express == 'Oui') && $the_combination['available_date'] <= $smarty.now|date_format:'%Y-%m-%d'}
                    {assign var=combinationExpress value=1}
                {/if}

                <span id="no_express_delivery"
                      class="{if $combinationExpress == 1}hidden{/if}">{l s='Delivery from'}
                    <strong>
                        <span class="delay_min">{if isset($the_combination['attributes_values'][9])}{$the_combination['attributes_values'][9]}{/if}</span> {l s='Delivery to'}
                        <span class="delay_max">{if isset($the_combination['attributes_values'][10])}{$the_combination['attributes_values'][10]}{/if}</span> {l s='weeks'}.
                    </strong>
                </span>
                <span class="delay_express_delivery{if Product::getRealQuantity($the_product->id, $the_combination_id) < 1 && $force_express != 'Oui'} hidden{/if}">
                    <span class="express_delivery light-tooltip{if $combinationExpress == 0} hidden{/if}"
                          style="{if Product::getRealQuantity($the_product->id, Product::getDefaultAttribute($the_product->id)) >= 1}display: inline-block{/if}"
                          data-toggle="tooltip" data-placement="bottom"
                          title="{l s='Livraison sous une semaine'}">{l s='Express delivery'}</span>
                </span>
            </p>
            <!-- /EXPRESS -->
            <!-- DECLINAISONS -->
            <div id="product_combinations_vignettes">
                {if $combColorMat|@count > 1}
                    {foreach from=$combColorMat item=mats key=combId}
                        {assign var='color' value=$mats[0]}
                        {assign var='mat' value=$mats[1]}
                        <a href="{$link->getProductLink($the_product->id, $the_product->link_rewrite, null, null, null, null, $combId)}" data-toggle="tooltip" data-placement="bottom" class="light-tooltip" data-trigger="manual"
                           title="{$colors[$color]['name']}/{$groups[4]['attributes'][$mat]}">
                            <span style="background: {$colors[$color]['value']} {if isset($colors[$color]['url']) && $colors[$color]['url'] != ''}url({$colors[$color]['url']}){/if}; background-size: cover;"></span>
                            <span style="background: {$colors[$mat]['value']} {if isset($colors[$mat]['url']) && $colors[$mat]['url'] != ''}url({$colors[$mat]['url']}) no-repeat{/if}; background-size: cover;"></span>
                        </a>
                    {/foreach}
                {/if}
            </div>
            <!-- /DECLINAISONS -->
            <!-- ADDTOCART -->
            {if $the_product->show_price || isset($groups) || $the_product->reference || (isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS)}
                <!-- add to cart form-->
                <form id="buy_block"{if $PS_CATALOG_MODE && !isset($groups) && $the_product->quantity > 0} class="hidden"{/if}
                      action="{$link->getPageLink('cart')|escape:'html':'UTF-8'}" method="post">
                    <!-- hidden datas -->
                    <p class="hidden">
                        <input type="hidden" name="token" value="{$static_token}"/>
                        <input type="hidden" name="id_product" value="{$the_product->id|intval}"
                               id="product_page_product_id"/>
                        <input type="hidden" name="add" value="1"/>
                        <input type="hidden" name="id_product_attribute" id="idCombination" value="{$the_combination_id}"/>
                    </p>
                    <div class="box-info-product">
                        <div class="box-cart-bottom">
                            <div>
                                <div id="add_to_cart" class="buttons_bottom_block no-print">
                                    <button type="submit" name="Submit"
                                            class="exclusive btn btn-primary{if $the_combination['available_date'] > $smarty.now|date_format:'%Y-%m-%d'} hidden{/if}">
                                        <span class="add">{if $content_only && (isset($the_product->customization_required) && $the_product->customization_required)}{l s='Customize'}{else}<span class="icon-shopping-bag icon-white"></span> &nbsp;{l s='Add to cart'}{/if}</span>
                                    </button>
                                    <span class="epuise text-uppercase{if $the_combination['available_date'] <= $smarty.now|date_format:'%Y-%m-%d'} hidden{/if}">{l s='Epuisé'}</span>
                                    <div id="block_quantity">
                                        <select id="quantity_wanted" class="selectpicker">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- end box-cart-bottom -->
                        <p id="available_stock" class="{if $the_combination['quantity'] < 1 || $the_combination['quantity'] > 5 || $the_combination['available_date'] > $smarty.now|date_format:'%Y-%m-%d'} hidden{/if}">
                            {l s='Only'}
                            <span id="available_stock_qty">{$the_combination['quantity']}</span>
                            {l s='products in stock!'}
                        </p>
                        <input type="hidden" value="{$timer_timestamp}" id="timer_timestamp"/>
                        <div id="timer" data-toggle="tooltip" data-placement="bottom" class="light-tooltip{if $combinationExpress == 1 || $the_combination['available_date'] > $smarty.now|date_format:'%Y-%m-%d'} hidden{/if}"
                             title="{l s='Pour vous proposer le meilleur prix pour cet article, nous groupons vos commandes quand le timer arrive à zéro et déclenchons sa fabrication. Passez commande dès maintenant pour être sur de faire partie du prochain lot de fabrication.'}">
                            <span id="days"></span> {l s='Days'},
                            <span id="hours"></span> :
                            <span id="minutes"></span> :
                            <span id="seconds"></span>
                        </div>

                    </div> <!-- end box-info-product -->
                </form>
            {/if}
            <!-- /ADDTOCART -->
            <!-- QTE -->
            {if ($display_qties == 1 && !$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && $the_product->available_for_order)}
                <!-- number of item in stock -->
                <p id="pQuantityAvailable"{if $the_product->quantity <= 0} style="display: none;"{/if}>
                    <span id="quantityAvailable">{$the_product->quantity|intval}</span>
                    <span {if $the_product->quantity > 1} style="display: none;"{/if}
                            id="quantityAvailableTxt">{l s='Item'}</span>
                    <span {if $the_product->quantity == 1} style="display: none;"{/if}
                            id="quantityAvailableTxtMultiple">{l s='Items'}</span>
                </p>
            {/if}
            <!-- /QTE -->
        </div>
        <div>
            <!-- DETAILS -->
            <div id="accordion" role="tablist" aria-multiselectable="true">
                <!-- INFOS -->
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingInfo">
                        <h4 class="panel-title text-uppercase">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseInfo" aria-expanded="true"
                               aria-controls="collapseInfo">{l s='Informations produit'}</a>
                        </h4>
                    </div>
                    <div id="collapseInfo" class="panel-collapse collapse in" role="tabpanel"
                         aria-labelledby="headingInfo">
                        <p class="data_sheet_element product_materials{if empty($product_materials)} hidden{/if}">
                            <span>{if !empty($product_materials)}{$groups[11]['group_name']} :{/if}</span>
                            <span id="product_materials">{$product_materials}</span>
                        </p>
                        {if isset($feats[13][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[13]['name']} : </span>
                                <span>{$feats[13][0]}</span>
                            </p>
                        {/if}
                        {*if $feats[19][0] != ''}
                            <div class="data_sheet_element">
                                <span>{$features_groups[19]['name']} :</span>
                                <span>{foreach from=$feats[19] item=pieceItem}{$pieceItem}<br />{/foreach}</span>
                            </div>
                        {/if*}
                        {if isset($feats[15][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[15]['name']} : </span>
                                <span>{$feats[15][0]}</span>
                            </p>
                        {/if}

                        <p class="data_sheet_element product_foot{if !isset($groups[25]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[25]['group_name'])}{$groups[25]['group_name']} :{/if}</span>
                            <span id="product_foot">{if isset($the_combination['attributes_values'][25])}{$the_combination['attributes_values'][25]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_finishing{if !isset($groups[12]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[12]['group_name'])}{$groups[12]['group_name']} :{/if}</span>
                            <span id="product_finishing">{if isset($the_combination['attributes_values'][12])}{$the_combination['attributes_values'][12]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_maintenance{if !isset($groups[26]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[26]['group_name'])}{$groups[26]['group_name']} :{/if}</span>
                            <span id="product_maintenance">{if isset($the_combination['attributes_values'][26])}{$the_combination['attributes_values'][26]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_special_caracteristics{if !isset($groups[27]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[27]['group_name'])}{$groups[27]['group_name']} :{/if}</span>
                            <span id="product_special_caracteristics">{if isset($the_combination['attributes_values'][27])}{$the_combination['attributes_values'][27]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_tray{if !isset($groups[29]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[29]['group_name'])}{$groups[29]['group_name']} :{/if}</span>
                            <span id="product_tray">{if isset($the_combination['attributes_values'][29])}{$the_combination['attributes_values'][29]}{/if}</span>
                        </p>

                        {if isset($feats[31][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[31]['name']} : </span>
                                <span>{$feats[31][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[32][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[32]['name']} : </span>
                                <span>{$feats[32][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[33][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[33]['name']} : </span>
                                <span>{$feats[33][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[34][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[34]['name']} : </span>
                                <span>{$feats[34][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[35][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[35]['name']} : </span>
                                <span>{$feats[35][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[36][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[36]['name']} : </span>
                                <span>{$feats[36][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[37][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[37]['name']} : </span>
                                <span>{$feats[37][0]}</span>
                            </p>
                        {/if}
                        <p class="data_sheet_element product_fabric{if !isset($groups[28]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[28]['group_name'])}{$groups[28]['group_name']}{/if} :</span>
                            <span id="product_fabric">{if isset($the_combination['attributes_values'][28])}{$the_combination['attributes_values'][28]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_bulb_type{if !isset($groups[30]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[30]['group_name'])}{$groups[30]['group_name']} :{/if}</span>
                            <span id="product_bulb_type">{if isset($the_combination['attributes_values'][30])}{$the_combination['attributes_values'][30]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_bulb_count{if !isset($groups[31]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[31]['group_name'])}{$groups[31]['group_name']} :{/if}</span>
                            <span id="product_bulb_count">{if isset($the_combination['attributes_values'][31])}{$the_combination['attributes_values'][31]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_max_power{if !isset($groups[32]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[32]['group_name'])}{$groups[32]['group_name']} :{/if}</span>
                            <span id="product_max_power">{if isset($the_combination['attributes_values'][32])}{$the_combination['attributes_values'][32]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_light_switch{if !isset($groups[33]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[33]['group_name'])}{$groups[33]['group_name']} :{/if}</span>
                            <span id="product_light_switch">{if isset($the_combination['attributes_values'][33])}{$the_combination['attributes_values'][33]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_cable_type{if !isset($groups[34]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[34]['group_name'])}{$groups[34]['group_name']} :{/if}</span>
                            <span id="product_cable_type">{if isset($the_combination['attributes_values'][34])}{$the_combination['attributes_values'][34]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_cable_length{if !isset($groups[35]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[35]['group_name'])}{$groups[35]['group_name']} :{/if}</span>
                            <span id="product_cable_length">{if isset($the_combination['attributes_values'][35])}{$the_combination['attributes_values'][35]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_fixation{if !isset($groups[36]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[36]['group_name'])}{$groups[36]['group_name']} :{/if}</span>
                            <span id="product_fixation">{if isset($the_combination['attributes_values'][36])}{$the_combination['attributes_values'][36]}{/if}</span>
                        </p>
                        <p class="data_sheet_element product_composition_tissu{if !isset($groups[39]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[39]['group_name'])}{$groups[39]['group_name']} :{/if}</span>
                            <span id="product_composition_tissu">{if isset($the_combination['attributes_values'][39])}{$the_combination['attributes_values'][39]}{/if}</span>
                        </p>
                        {if isset($feats[39][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[39]['name']} : </span>
                                <span>{$feats[39][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[40][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[40]['name']} : </span>
                                <span>{$feats[40][0]}</span>
                            </p>
                        {/if}
                        <p class="data_sheet_element product_light_color{if !isset($groups[37]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[37]['group_name'])}{$groups[37]['group_name']} :{/if}</span>
                            <span id="product_light_color">{if isset($the_combination['attributes_values'][37])}{$the_combination['attributes_values'][37]}{/if}</span>
                        </p>
                        {*<div class="data_sheet_element">
                            <span>{l s='Collection'} : </span>
                            <span>{if $feats[13] != ''}{$feats[13]}{else}-{/if}</span>
                        </div>*}
                    </div>
                </div>
                <!-- /INFOS -->
                <!-- LIVRAISON -->
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingDelivery">
                        <h4 class="panel-title text-uppercase">
                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion"
                               href="#collapseDelivery" aria-expanded="false"
                               aria-controls="collapseDelivery">{l s='Livraison & Retours'}</a>
                        </h4>
                    </div>
                    <div id="collapseDelivery" class="panel-collapse collapse" role="tabpanel"
                         aria-labelledby="headingDelivery">
                        <p>
                            <span id="no_express_delivery"
                                  class="{if $combinationExpress == 1} hidden{/if}">{l s='Delivery from'}
                                <strong>
                                    <span class="delay_min">{if isset($the_combination['attributes_values'][9])}{$the_combination['attributes_values'][9]}{/if}</span> {l s='Delivery to'}
                                    <span class="delay_max">{if isset($the_combination['attributes_values'][10])}{$the_combination['attributes_values'][10]}{/if}</span> {l s='weeks'}.
                                </strong>
                            </span>
                            <span class="delay_express_delivery{if $combinationExpress == 0} hidden{/if}">{l s='Livraison sous une semaine'}</span>
                        </p>
                        <p>
                            {l s='Shipping fees'} :
                            <strong class="shipping_fees">{if isset($the_combination['shipping_fees'])}{$the_combination['shipping_fees']}{/if}</strong>
                        </p>
                        <section id="text_more_info">
                            <p>{l s='En savoir plus'} : </p>
                            <ul id="livraison_savoir_plus">
                                <li>
                                    <a target="_top" href="{$link->getCMSLink(14, 'retours-remboursements')|escape:'html':'UTF-8'}">{l s='Remboursement'}</a>
                                </li>
                                <li>
                                    <a target="_top" href="{$link->getCMSLink(14, 'retours-remboursements')|escape:'html':'UTF-8'}">{l s='Retours'}</a>
                                </li>
                                <li>
                                    <a target="_top" href="{$link->getCMSLink(13, 'nos-livraisons')|escape:'html':'UTF-8'}">{l s='Livraison'}</a>
                                <li>
                                    <a target="_top" href="{$link->getCMSLink(12, 'le-concept-nv-gallery')|escape:'html':'UTF-8'}">{l s='Notre concept'}</a>
                                </li>
                            </ul>
                        </section>
                    </div>
                </div>
                <!-- /LIVRAISON -->
                <!-- DIMENSIONS -->
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingCollapseDimension">
                        <h4 class="panel-title text-uppercase">
                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion"
                               href="#collapseDimension" aria-expanded="false"
                               aria-controls="collapseDimension">{l s='Dimensions'}</a>
                        </h4>
                    </div>
                    <div id="collapseDimension" class="panel-collapse collapse" role="tabpanel"
                         aria-labelledby="headingCollapseDimension">
                        {if $feats[1][0] > 0 || $feats[2][0] > 0 || $feats[3][0] > 0 || $feats[17][0] > 0}
                            <p class="data_sheet_element">
                                <span>{l s='General dimensions'} : </span>
                                <span>
                                    {if $feats[1][0] > 0}H{$feats[1][0]} {if $feats[17][0] > 0 || $feats[3][0] > 0 || $feats[2][0] > 0}x {/if}{/if}

                                    {if $feats[17][0] > 0}D{$feats[17][0]} {if $feats[3][0] > 0 || $feats[2][0] > 0}x {/if}{/if}
                                    {if $feats[3][0] > 0}P{$feats[3][0]} {if $feats[2][0] > 0}x {/if}{/if}
                                    {if $feats[2][0] > 0}L{$feats[2][0]}{/if} {l s='cm'}
                                </span>
                            </p>
                        {/if}
                        {if isset($feats[21][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[21]['name']} : </span>
                                <span>{$feats[21][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[22][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[22]['name']} : </span>
                                <span>{$feats[22][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[23][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[23]['name']} : </span>
                                <span>{$feats[23][0]}</span>
                            </p>
                        {/if}
                        <p class="data_sheet_element product_tray_thickness{if !isset($groups[23]['group_name'])} hidden{/if}">
                            <span>{if isset($groups[23]['group_name'])}{$groups[23]['group_name']} :{/if}</span>
                            <span id="product_tray_thickness">{if isset($the_combination['attributes_values'][23])}{$the_combination['attributes_values'][23]}{/if}</span>
                        </p>
                        {if isset($feats[14][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[14]['name']} : </span>
                                <span>{$feats[14][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[24][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[24]['name']} : </span>
                                <span>{$feats[24][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[25][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[25]['name']} : </span>
                                <span>{$feats[25][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[26][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[26]['name']} : </span>
                                <span>{$feats[26][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[27][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[27]['name']} : </span>
                                <span>{$feats[27][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[28][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[28]['name']} : </span>
                                <span>{$feats[28][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[29][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[29]['name']} : </span>
                                <span>{$feats[29][0]}</span>
                            </p>
                        {/if}
                        <p class="data_sheet_element">
                            <span>{l s='Poids du colis'}</span>
                            <span id="product_weight">{($the_product->weight + $the_combination['weight'])|string_format:"%.2f"}
                                Kg</span>
                        </p>
                        {if isset($feats[30][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[30]['name']} : </span>
                                <span>{$feats[30][0]}</span>
                            </p>
                        {/if}

                        {if $the_product->height > 0 || $the_product->width > 0 || $the_product->depth > 0}
                            <p class="data_sheet_element">
                                <span>{l s='Package dimensions'} : </span>
                                <span id="package_dimensions">{if $the_product->height}H{$the_product->height|string_format:"%.2f"} x {/if}{if $the_product->depth}P{$the_product->depth|string_format:"%.2f"} x {/if}{if $the_product->width}L{$the_product->width|string_format:"%.2f"}{/if} {l s='cm'}</span>
                            </p>
                        {/if}

                        {if isset($feats[42][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[42]['name']} : </span>
                                <span>{$feats[42][0]}</span>
                            </p>
                        {/if}
                        {if isset($feats[43][0])}
                            <p class="data_sheet_element">
                                <span>{$features_groups[43]['name']} : </span>
                                <span>{$feats[43][0]}</span>
                            </p>
                        {/if}
                    </div>
                </div>

                <!-- /DIMENSIONS -->
                <!-- DESCRIPTIF -->
                {if $the_product->description_short}
                    <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingCollapseDescriptif">
                        <h4 class="panel-title text-uppercase">
                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion"
                               href="#collapseDescriptif" aria-expanded="false"
                               aria-controls="collapseDescriptif">{l s='Style'}</a>
                        </h4>
                    </div>
                    <div id="collapseDescriptif" class="panel-collapse collapse in" role="tabpanel"
                         aria-labelledby="headingCollapseDescriptif">
                        <div id="short_description_content" class="rte align_justify"
                             itemprop="description">{$the_product->description_short}
                            <p id="complement_resume">{if isset($the_combination['complement_resume'])}{$the_combination['complement_resume']|nl2br}{/if}</p>
                        </div>
                    </div>
                    </div>{/if}
                <!-- /DESCRIPTIF -->

                <!-- DESCRIPTIF LONG -->
                {if $the_product->description}
                    <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingCollapseDescriptifLong">
                        <h4 class="panel-title text-uppercase">
                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion"
                               href="#collapseDescriptifLong" aria-expanded="false"
                               aria-controls="collapseDescriptifLong">{l s='Ses petits + !'}</a>
                        </h4>
                    </div>
                    <div id="collapseDescriptifLong" class="panel-collapse collapse" role="tabpanel"
                         aria-labelledby="headingCollapseDescriptifLong">
                        <div id="short_description_content" class="rte align_justify"
                             itemprop="description">{$the_product->description}
                            <p id="complement_description">{if isset($the_combination['complement_description'])}{$the_combination['complement_description']|nl2br}{/if}</p>
                        </div>
                    </div>
                    </div>{/if}
                <!-- /DESCRIPTIF LONG-->

            </div>
            <!-- /DETAILS -->
        </div>
        {if isset($HOOK_PRODUCT_FOOTER) && $HOOK_PRODUCT_FOOTER}{$HOOK_PRODUCT_FOOTER}{/if}
        <div>
            {if $discover_collection_products|@count > 1}
                <section id="discover_collection"
                         class="{if $discover_collection_img_large != ''} carrousel_columns_{if $discover_collection_img_large == '_large'}2{elseif $discover_collection_img_large == '_xlarge'}1{/if}{/if}">
                    <h4 class="text-uppercase text-xs-center">{l s="Discover the collection"} "{$feats[13][0]}"</h4>
                    <div id="discover_collection_image"><img src="{$discover_collection_img}" alt=""/></div>
                    <div id="block_collection_carrousel">
                        {assign var='nbPerLine' value=3}
                        {if $discover_collection_img_large == '_large'}
                            {assign var='nbPerLine' value=2}
                        {elseif $discover_collection_img_large == '_xlarge'}
                            {assign var='nbPerLine' value=1}
                        {/if}
                        {include file="./product-list.tpl" products=$discover_collection_products nb_products_per_line=$nbPerLine isCarrousel=true}
                    </div>
                </section>
            {/if}
        </div>
    </div>
    <!-- /ROW -->

    <!-- itemscope product wrapper -->
    {strip}
        {if isset($smarty.get.ad) && $smarty.get.ad}
            {addJsDefL name=ad}{$base_dir|cat:$smarty.get.ad|escape:'html':'UTF-8'}{/addJsDefL}
        {/if}
        {if isset($smarty.get.adtoken) && $smarty.get.adtoken}
            {addJsDefL name=adtoken}{$smarty.get.adtoken|escape:'html':'UTF-8'}{/addJsDefL}
        {/if}
        {addJsDef allowBuyWhenOutOfStock=$allow_oosp|boolval}
        {addJsDef availableNowValue=$the_product->available_now|escape:'quotes':'UTF-8'}
        {addJsDef availableLaterValue=$the_product->available_later|escape:'quotes':'UTF-8'}
        {addJsDef attribute_anchor_separator=$attribute_anchor_separator|escape:'quotes':'UTF-8'}
        {addJsDef attributesCombinations=$attributesCombinations}
        {addJsDef currentDate=$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
        {if isset($combinations) && $combinations}
            {addJsDef combinations=$combinations}
            {addJsDef combinationsFromController=$combinations}
            {addJsDef displayDiscountPrice=$display_discount_price}
            {addJsDefL name='upToTxt'}{l s='Up to' js=1}{/addJsDefL}
        {/if}
        {if isset($combinationImages) && $combinationImages}
            {addJsDef combinationImages=$combinationImages}
        {/if}
        {addJsDef the_combination_id=$the_combination_id}
        {addJsDef customizationId=$id_customization}
        {addJsDef customizationFields=$customizationFields}
        {addJsDef default_eco_tax=$the_product->ecotax|floatval}
        {addJsDef displayPrice=$priceDisplay|intval}
        {addJsDef ecotaxTax_rate=$ecotaxTax_rate|floatval}
        {if isset($cover.id_image_only)}
            {addJsDef idDefaultImage=$cover.id_image_only|intval}
        {else}
            {addJsDef idDefaultImage=0}
        {/if}
        {addJsDef img_ps_dir=$img_ps_dir}
        {addJsDef img_prod_dir=$img_prod_dir}
        {addJsDef id_product=$the_product->id|intval}
        {addJsDef jqZoomEnabled=$jqZoomEnabled|boolval}
        {addJsDef maxQuantityToAllowDisplayOfLastQuantityMessage=$last_qties|intval}
        {addJsDef minimalQuantity=$the_product->minimal_quantity|intval}
        {addJsDef noTaxForThisProduct=$no_tax|boolval}
        {if isset($customer_group_without_tax)}
            {addJsDef customerGroupWithoutTax=$customer_group_without_tax|boolval}
        {else}
            {addJsDef customerGroupWithoutTax=false}
        {/if}
        {if isset($group_reduction)}
            {addJsDef groupReduction=$group_reduction|floatval}
        {else}
            {addJsDef groupReduction=false}
        {/if}
        {addJsDef oosHookJsCodeFunctions=Array()}
        {addJsDef productHasAttributes=isset($groups)|boolval}
        {addJsDef productPriceTaxExcluded=($the_product->getPriceWithoutReduct(true)|default:'null' - $the_product->ecotax)|floatval}
        {addJsDef productPriceTaxIncluded=($the_product->getPriceWithoutReduct(false)|default:'null' - $the_product->ecotax * (1 + $ecotaxTax_rate / 100))|floatval}
        {addJsDef productBasePriceTaxExcluded=($the_product->getPrice(false, null, 6, null, false, false) - $the_product->ecotax)|floatval}
        {addJsDef productBasePriceTaxExcl=($the_product->getPrice(false, null, 6, null, false, false)|floatval)}
        {addJsDef productBasePriceTaxIncl=($the_product->getPrice(true, null, 6, null, false, false)|floatval)}
        {addJsDef productReference=$the_product->reference|escape:'html':'UTF-8'}
        {addJsDef productAvailableForOrder=$the_product->available_for_order|boolval}
        {addJsDef productPriceWithoutReduction=$productPriceWithoutReduction|floatval}
        {addJsDef productPrice=$productPrice|floatval}
        {addJsDef productUnitPriceRatio=$the_product->unit_price_ratio|floatval}
        {addJsDef productShowPrice=(!$PS_CATALOG_MODE && $the_product->show_price)|boolval}
        {addJsDef PS_CATALOG_MODE=$PS_CATALOG_MODE}
        {if $the_product->specificPrice && $the_product->specificPrice|@count}
            {addJsDef product_specific_price=$the_product->specificPrice}
        {else}
            {addJsDef product_specific_price=array()}
        {/if}
        {if $display_qties == 1 && $the_product->quantity}
            {addJsDef quantityAvailable=$the_product->quantity}
        {else}
            {addJsDef quantityAvailable=0}
        {/if}
        {addJsDef quantitiesDisplayAllowed=$display_qties|boolval}
        {if $the_product->specificPrice && $the_product->specificPrice.reduction && $the_product->specificPrice.reduction_type == 'percentage'}
            {addJsDef reduction_percent=$the_product->specificPrice.reduction*100|floatval}
        {else}
            {addJsDef reduction_percent=0}
        {/if}
        {if $the_product->specificPrice && $the_product->specificPrice.reduction && $the_product->specificPrice.reduction_type == 'amount'}
            {addJsDef reduction_price=$the_product->specificPrice.reduction|floatval}
        {else}
            {addJsDef reduction_price=0}
        {/if}
        {if $the_product->specificPrice && $the_product->specificPrice.price}
            {addJsDef specific_price=$the_product->specificPrice.price|floatval}
        {else}
            {addJsDef specific_price=0}
        {/if}
        {addJsDef specific_currency=($the_product->specificPrice && $the_product->specificPrice.id_currency)|boolval} {* TODO: remove if always false *}
        {addJsDef stock_management=$PS_STOCK_MANAGEMENT|intval}
        {addJsDef initial_weight=$product->weight}
        {addJsDef taxRate=$tax_rate|floatval}
        {addJsDefL name=doesntExist}{l s='This combination does not exist for this product. Please select another combination.' js=1}{/addJsDefL}
        {addJsDefL name=doesntExistNoMore}{l s='This product is no longer in stock' js=1}{/addJsDefL}
        {addJsDefL name=doesntExistNoMoreBut}{l s='with those attributes but is available with others.' js=1}{/addJsDefL}
        {addJsDefL name=fieldRequired}{l s='Please fill in all the required fields before saving your customization.' js=1}{/addJsDefL}
        {addJsDefL name=uploading_in_progress}{l s='Uploading in progress, please be patient.' js=1}{/addJsDefL}
        {addJsDefL name='product_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
        {addJsDefL name='product_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
    {/strip}
{/if}