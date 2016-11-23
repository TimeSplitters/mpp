<div class="col-xs-12 col-sm-12">
    {capture name=path}
        <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
            {l s='My account'}
        </a>
        <span class="navigation-pipe">
        {$navigationPipe}
    </span>
        <span class="navigation_page">
        {l s='Customer service'}
    </span>
    {/capture}

    <div class="page-header">
        <div>
            {include file="{$tpl_dir}mobile/espace_client_sublinks.tpl" titleAccordion={l s='Service client'}}
        </div>
        {include file="{$tpl_dir}mobile/my-account-add-address.tpl"}
        <div class="clearfix"></div>
    </div>
    <div class="my-account-content-block">
        {if isset($confirmation)}
            <p class="sent_success">{l s='Your message has been successfully sent to our team.'}</p>
        {elseif isset($alreadySent)}
            <p class="already_sent_success">{l s='Your message has already been sent.'}</p>
        {/if}
        {if $smarty.get.id_contact == 4}
            <p>{l s='To return an item, please fill in the form below. Don\'t forget to precise your order number!'}</p>{/if}
        <div>
            <div class="contact-info-blocks">
                <h5 class="page-subheading">{l s='send a message'}</h5>
                <form id="contact-form" action="{$request_uri}" method="post" class="contact-form-box fieldset_form"
                      enctype="multipart/form-data">
                    <div class="clearfix">
                        <div>
                            <div class="form-group">
                                <input class="form-control grey validate" type="text" id="email"
                                       name="from" data-validate="isEmail"
                                       placeholder="{l s='Email address'}"
                                       value="{if isset($customerThread.email)}{$customerThread.email|escape:'html':'UTF-8'}{else}{$email|escape:'html':'UTF-8'}{/if}"/>
                                <div class="error_message">{$errors['email']}</div>
                            </div>
                            <div class="form-group">
                                <input class="form-control grey validate" type="text" id="name"
                                       name="name" data-validate="isGenericName"
                                       placeholder="{l s='Firstname'}"
                                       value="{if isset($customerThread.customer_name)}{$customerThread.customer_name|escape:'html':'UTF-8'}{else}{$name|escape:'html':'UTF-8'}{/if}"/>
                                <div class="error_message">{$errors['name']}</div>
                            </div>
                            <div class="form-group">
                                <select id="id_contact" class="form-control" name="id_contact">
                                    <option value="0" disabled>{l s='Object'}</option>
                                    {foreach from=$contacts item=contact}
                                        <option value="{$contact.id_contact|intval}"{if (isset($smarty.request.id_contact) && $smarty.request.id_contact == $contact.id_contact) || ($customerThread.id_contact && $contact.id_contact == $customerThread.id_contact|intval)} selected="selected" style="color: #18b003;"{/if}>{$contact.name|escape:'html':'UTF-8'}</option>
                                    {/foreach}
                                </select>
                                {*
                                <p id="desc_contact0" class="desc_contact{if isset($smarty.request.id_contact)} unvisible{/if}">&nbsp;</p>
                                {foreach from=$contacts item=contact}
                                    <p id="desc_contact{$contact.id_contact|intval}" class="desc_contact contact-title{if !isset($smarty.request.id_contact) || $smarty.request.id_contact|intval != $contact.id_contact|intval} unvisible{/if}">
                                        <i class="icon-comment-alt"></i>{$contact.description|escape:'html':'UTF-8'}
                                    </p>
                                {/foreach}
                                *}
                                <div class="error_message">{$errors['subject']}</div>
                            </div>
                            {*if !$PS_CATALOG_MODE}
                                {if (!isset($customerThread.id_order) || $customerThread.id_order > 0)}
                                    <div class="form-group">
                                        <fieldset>
                                            <legend>
                                                <label id="label_id_order" for="id_order">
                                                    {l s='Order reference'}
                                                </label>
                                            </legend>

                                        {if !isset($customerThread.id_order) && isset($is_logged) && $is_logged}
                                            <select name="id_order" class="form-control">
                                                <option value="0">{l s='-- Choose --'}</option>
                                                {foreach from=$orderList item=order}
                                                    <option value="{$order.value|intval}"{if $order.selected|intval} selected="selected"{/if}>{$order.label|escape:'html':'UTF-8'}</option>
                                                {/foreach}
                                            </select>
                                        {elseif !isset($customerThread.id_order) && empty($is_logged)}
                                            <input class="form-control grey" type="text" name="id_order" id="id_order" value="{if isset($customerThread.id_order) && $customerThread.id_order|intval > 0}{$customerThread.id_order|intval}{else}{if isset($smarty.post.id_order) && !empty($smarty.post.id_order)}{$smarty.post.id_order|escape:'html':'UTF-8'}{/if}{/if}" />
                                        {elseif $customerThread.id_order|intval > 0}
                                            <input class="form-control grey" type="text" name="id_order" id="id_order" value="{if isset($customerThread.reference) && $customerThread.reference}{$customerThread.reference|escape:'html':'UTF-8'}{else}{$customerThread.id_order|intval}{/if}" readonly="readonly" />
                                        {/if}
                                        </fieldset>
                                    </div>
                                {/if}
                                {if isset($is_logged) && $is_logged}
                                    <div class="form-group">
                                        <fieldset>
                                            <legend>
                                                <label id="label_id_order" for="id_order">
                                                    {l s='Product'}
                                                </label>
                                            </legend>

                                        {if !isset($customerThread.id_product)}
                                            {foreach from=$orderedProductList key=id_order item=products name=products}
                                                <select name="id_product" id="{$id_order}_order_products" class="unvisible product_select form-control"{if !$smarty.foreach.products.first} style="display:none;"{/if}{if !$smarty.foreach.products.first} disabled="disabled"{/if}>
                                                    <option value="0">{l s='-- Choose --'}</option>
                                                    {foreach from=$products item=product}
                                                        <option value="{$product.value|intval}">{$product.label|escape:'html':'UTF-8'}</option>
                                                    {/foreach}
                                                </select>
                                            {/foreach}
                                        {elseif $customerThread.id_product > 0}
                                            <input  type="hidden" name="id_product" id="id_product" value="{$customerThread.id_product|intval}" readonly="readonly" />
                                        {/if}
                                    </div>
                                {/if}
                            {/if*}
                            {*if $fileupload == 1}
                            <div class="form-group">
                                <fieldset class="forceActive">
                                    <legend>
                                        <label id="label_fileUpload" for="fileUpload">
                                            {l s='Attach file'}
                                        </label>
                                    </legend>

                                    <input type="hidden" name="MAX_FILE_SIZE" value="{if isset($max_upload_size) && $max_upload_size}{$max_upload_size|intval}{else}2000000{/if}" />
                                    <input type="file" name="fileUpload" id="fileUpload" class="form-control" />
                                </fieldset>
                                <div class="error_message">{$errors['file_upload']}</div>
                            </div>
                            {/if*}
                            <div class="form-group">
                                <textarea placeholder="{l s='Message'}" class="form-control" style="height: 100px;"
                                          id="message"
                                          name="message">{if isset($message)}{$message|escape:'html':'UTF-8'|stripslashes}{/if}</textarea>
                                <div class="error_message">{$errors['message']}</div>
                            </div>
                            <div>
                                <button type="submit" class="btn btn-default" name="submitMessage"
                                        id="submitMessage">{l s='Send'}</button>
                            </div>
                        </div>
                    </div>
                    <strong class="success_message">{l s='Your information has been saved.'}</strong>
                    <div class="error_message">{$errors['general']}</div>
                </form>
            </div>

            <div class="contact-info-blocks">
                <h5 class="page-subheading">{l s='#SuperCustomerService'}</h5>
                <div class="contact-grey-block">
                    <div class="row gutter-10">
                        <div class="col-xs-2 text-center">
                            <span class="icon-envelope"></span>
                        </div>
                        <div class="col-xs-10 text-center">
                            <span>{l s='Contact us by email'}:</span><br/>
                            {mailto address='hello@monpotpourri.com' encode="hex"}
                        </div>
                    </div>
                    <div class="row gutter-10">
                        <div class="col-xs-2 text-center">
                            <span class="icon-mobile"></span>
                        </div>
                        <div class="col-xs-10 text-center">
                            <span>{l s='Call us for free'}:</span><br/>
                            <a href="tel:{Configuration::get('PS_SHOP_PHONE')}"><span
                                        class="phone_number">{Configuration::get('PS_SHOP_PHONE')}</span></a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>

        <div>
            <h5 class="page-subheading">{l s='Most frequent questions'}</h5>

            <div class="row gutter-10">
                <div class="col-xs-6 contact-grey-block vcenter">
                    <a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}"
                       class="faq-link">
                        <span>{l s='Where is my order?'}</span>
                    </a>
                </div>
                <div class="col-xs-6 contact-grey-block vcenter">
                    <a href="{$link->getPageLink('contact', true)|escape:'html':'UTF-8'}?id_contact=3"
                       class="faq-linkk">
                        <span>{l s='How to change or cancel an order?'}</span>
                    </a>
                </div>
            </div>
            <div class="row gutter-10">
                <div class="col-xs-6 contact-grey-block vcenter">
                    <a href="{$link->getCMSLink(14, 'retours-remboursements')|escape:'html':'UTF-8'}"
                       class="faq-link">
                        <span>{l s='I would like to return a product'}</span>
                    </a>
                </div>
                <div class="col-xs-6 contact-grey-block vcenter">
                    <a href="{$link->getCMSLink(13, "nos-livraisons")|escape:'html':'UTF-8'}"
                       class="faq-link">
                        <span>{l s='What are your delivery modes?'}</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
{addJsDefL name='contact_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
{addJsDefL name='contact_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
