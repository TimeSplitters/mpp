{if isset($products) && $products}
    <!-- Products list -->
    {*<p class="hidden" id="added_to_wishlist">{l s='This product has been added to your Wishlist. Find it at any time in you customer area.'}</p>*}
    <div class="carrousel">
    <div{if isset($id) && $id} id="{$id}"{/if} class="product_list {if isset($class) && $class} {$class}{/if}">
        {assign var='checkThree' value=1}
        {assign var='count' value=1}

        {foreach from=$products item=product name=products}
            {if isset($isCarrousel) && $count <= 4 || !isset($isCarrousel) || !$isCarrousel}
            {if (isset($smarty.get.id_category) && $smarty.get.id_category != 12) || $product['new'] == 1 || !isset($smarty.get.id_category)}
                <div id="pid_{$product.id_product_attribute}"
                     class="card">
                    <a class="product_img_link"
                       href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, null, $product.id_product_attribute)|escape:'htmlall':'UTF-8'}"
                       itemprop="url">
                        <img class="replace-2x img-fluid"
                             src="{$link->getImageLink($product.link_rewrite, $product.last_image_id, 'home_default')|escape:'html':'UTF-8'}"
                             alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}"
                             itemprop="image"/>
                    </a>

                    {if Product::getMacaron($product.id_product_attribute) != 0}
                        <div class="card-img-overlay">
                            <a class="sale-box"
                               href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, null, $product.id_product_attribute)|escape:'htmlall':'UTF-8'}"
                               style="
                                       {if $combinations[$product.id_product_attribute]['attributes_values'][8] != 'undefined'}display: block{else}display: none{/if}">
                                <img src="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}img/co/{Product::getMacaron($product.id_product_attribute)}.jpg"/>
                            </a>
                        </div>
                    {/if}
                    {if !isset($isCarrousel) || !$isCarrousel}
                        <div class="block_express_delivery">
                            {if Product::getRealQuantity($product.id_product,$product.id_product_attribute) >= 1}
                                <span class="express_delivery{if $product.available_date > $smarty.now|date_format:'%Y-%m-%d'} hidden{/if}">{l s='Express delivery'}</span>
                            {/if}
                        </div>
                        <div>
                            <a class="product-name"
                                                   href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, null, $product.id_product_attribute)|escape:'htmlall':'UTF-8'}"
                                                   itemprop="url">
                                {$product.name|truncate:45:'...'|escape:'html':'UTF-8'}
                            </a>
                            <span class="product_main_category">
                                {$product.main_cat}
                            </span>
                            <br />
                            <span class="product_main_attributes">
                            {$product.main_attributes}
                        </span>
                        </div>
                        <div class="card-text">
                            {hook h="displayProductPriceBlock" product=$product type="weight"}
                            {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                                <div class="content_price">
                                    {if isset($product.show_price) && $product.show_price}
                                        {hook h="displayProductPriceBlock" product=$product type='before_price'}
                                        <span class="price product-price{if isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0} price-reduced{/if}">
                                    {convertPrice price=$product.price}
                                </span>
                                        {if isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
                                            {hook h="displayProductPriceBlock" product=$product type="old_price"}
                                            <span class="old-price product-price">
                                    {displayPrice price=$product.price_without_reduction}
                                </span>
                                            {hook h="displayProductPriceBlock" id_product=$product.id_product type="old_price"}
                                            {if $product.specific_prices.reduction_type == 'percentage'}
                                                {*<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>*}
                                            {/if}
                                        {/if}
                                        {hook h="displayProductPriceBlock" product=$product type="price"}
                                        {hook h="displayProductPriceBlock" product=$product type="unit_price"}
                                        {hook h="displayProductPriceBlock" product=$product type='after_price'}

                                        {if $product.prix_constate > 0}
                                            <span style="display: block">
                                    {l s='Typical price'}
                                                <span class="old_price_display">
                                        {displayPrice price=$product.prix_constate}
                                    </span>
                                </span>
                                        {/if}
                                    {/if}
                                </div>
                            {/if}
                            <div class="product-flags">
                                {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                                    {if isset($product.online_only) && $product.online_only}
                                        <span class="online_only">{l s='Online only'}</span>
                                    {/if}
                                {/if}
                                {if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
                                {elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
                                    <span class="discount">{l s='Reduced price!'}</span>
                                {/if}
                            </div>
                            {if (!$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                                {if isset($product.available_for_order) && $product.available_for_order}

                                {/if}
                            {/if}
                        </div>
                        <!-- .card-text -->
                    {/if}
                </div>
                <!-- .card -->
            {/if}
            {/if}
            {assign var='count' value=$count+1}
        {/foreach}
    </div>
    </div>
    {addJsDefL name=min_item}{l s='Please select at least one product' js=1}{/addJsDefL}
    {addJsDefL name=max_item}{l s='You cannot add more than %d product(s) to the product comparison' sprintf=$comparator_max_item js=1}{/addJsDefL}
    {addJsDef comparator_max_item=$comparator_max_item}
    {addJsDef comparedProductsIds=$compared_products}
{/if}