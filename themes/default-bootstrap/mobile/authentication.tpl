<div class="col-xs-12 col-sm-12">
    <p class="hidden"
   id="added_to_wishlist">{l s='This product has been added to your Wishlist. Find it at any time in you customer area.'}</p>
{if $smarty.get.message == 'completeAccountOK' OR $smarty.get.message == 'addToWishlistCreateAccountOK'}
    <h1 class="page-heading">{l s='Congratulations !'}</h1>
    <p class="text-center">{l s='Vous faites partie de la communauté Mon Pot Pourri !'}
        <br/>{l s='Pour vous remercier, nous vous offrons une réduction de 15 EUR sur votre première commande*.'}
        <br/>
        <br/>
        {l s='With the code: '}<strong>{l s='WELCOME'}</strong>
    </p>
    <div class="text-center">

        {if $smarty.get.message != 'addToWishlistCreateAccountOK'}
            <button id="enjoy-button" data-href="{$link->getCategoryLink(61)}"
                    class="btn btn-default">{l s='Let me enjoy it !'}</button>
            <button id="my-account-button"
                    data-href="{$link->getPageLink('my-account', true, NULL)|escape:'html':'UTF-8'}"
                    class="btn btn-default">{l s='To my account'}</button>
        {else}
            <script>
                setInterval(function () {
                    window.parent.$.fancybox.close();
                }, 10000);
            </script>
            <p>
                {l s='This product has been added to your Wishlist. Find it at any time in you customer area.'}
                <br/>
                <button type="button" id="addToWishlistCreatedContinue" name="addToWishlistCreatedContinue"
                        class="button btn btn-default button-medium">
                <span>
                    {l s='Continue'}
                </span>
                </button>
                <button type="button" id="addToWishlistCreatedToAccount" name="addToWishlistCreatedToAccount"
                        class="button btn btn-default button-medium">
                <span>
                    {l s='Go to my customer account'}
                </span>
                </button>
            </p>
        {/if}
    </div>
    <br/>
    <br/>
    <p class="text-center">
        <small>{l s='*Offre valable pour toute commande d\'un montant minimum de 100 EUR TTC, réalisée dans un délai de 15 jours à compter de votre inscription. Saisissez le code sur la page de paiement.'}</small>
    </p>
{elseif $smarty.get.message == 'addedToWishlist'}
    <p id="added_to_wishlist">{l s='This product has been added to your Wishlist. Find it at any time in you customer area.'}</p>
{else}
    {capture name=path}
        {if !isset($email_create)}
            {l s='Authentication'}
        {else}
            <a href="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" rel="nofollow"
               title="{l s='Authentication'}">{l s='Authentication'}</a>
            <span class="navigation-pipe">{$navigationPipe}</span>{l s='Authentication'}
        {/if}
    {/capture}

    {if isset($smarty.get.message)}
        {if $smarty.get.message == 'addToWishlist'}
            <p class="get_message">{l s='This article is incredible, isn\'t it?'}
                <br/>{l s='You have to register to find it back in your Wishlist.'} {l s='Don\'t worry, it\'s fast and easy!'}
            </p>
        {elseif $smarty.get.message == 'connectToWishlist'}
            <p>{l s='You can save your favorite articles in your Mon Pot Pourri\'s wishlist and find them at any time! Create and manage your wishlist as you... wish!'}
                <br/>{l s='You have to register to find it back in your Wishlist.'} {l s='Don\'t worry, it\'s fast and easy!'}
            </p>
        {/if}
    {/if}
    {if isset($back) && preg_match("/^http/", $back)}{assign var='current_step' value='login'}{include file="$tpl_dir./order-steps.tpl"}{/if}
    {*include file="$tpl_dir./errors.tpl"*}
    {assign var='stateExist' value=false}
    {assign var="postCodeExist" value=false}
    {assign var="dniExist" value=false}
    {*{if !isset($email_create)}*}
    {*{if isset($authentification_error)}
    <div class="alert alert-danger">
    {if {$authentification_error|@count} == 1}
    <p>{l s='There\'s at least one error'} :</p>
    {else}
    <p>{l s='There are %s errors' sprintf=[$account_error|@count]} :</p>
    {/if}
    <ol>
    {foreach from=$authentification_error item=v}
    <li>{$v}</li>
    {/foreach}
    </ol>
    </div>
    {/if}*}
    <div>
        <div class="auth-boxes">
            <form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}{if $smarty.get.content_only == '1'}?content_only=1{/if}"
                  method="post"
                  id="login_form" novalidate class="box fieldset_form">
                <h2>{l s='Log in'}</h2>
                <div class="alert alert-danger" id="general_login_error" style="display:none"></div>
                <div class="form_content clearfix">
                    <div class="form-group">
                        <p id="mail_already_exists">{l s='We know each other don\'t we?'} <br/>
                            {l s='Did you forget your password?'}
                            <br/><a href="{$link->getPageLink('password')|escape:'html':'UTF-8'}"
                                    rel="nofollow">{l s='Click here to change it'}</a></p>
                        <input class="is_required validate form-control" data-validate="isEmail"
                               type="email" placeholder="{l s='Email address'}"
                               id="email" name="email"
                               value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}"/>
                        <div id="email_error" class="error_message"></div>
                    </div>
                    <div class="form-group">
                        <div class="lost_password form-group text-right">
                            <a href="{$link->getPageLink('password')|escape:'html':'UTF-8'}{if $smarty.get.message == 'connectToWishlist' || $smarty.get.message == 'addToWishlist'}?message={$smarty.get.message}{/if}"
                               rel="nofollow">{l s='Forgot your password?'}</a>
                        </div>
                        <input class="is_required validate account_input form-control"
                               type="password" placeholder="{l s='Password'}"
                               data-validate="isPasswd" id="passwd" name="passwd" value=""/>
                        <div id="passwd_error" class="error_message"></div>
                        <div id="general_error" class="error_message"></div>
                    </div>
                </div>
                <div class="text-center">
                    {if isset($back)}<input type="hidden" class="hidden" name="back"
                                            value="{$back|escape:'html':'UTF-8'}" />{/if}
                    {if isset($pid)}<input type="hidden" class="hidden" name="pid"
                                           value="{$pid|escape:'html':'UTF-8'}" />{/if}
                    <button type="submit" id="SubmitLogin" name="SubmitLogin" class="btn btn-default btn-block">
                    <span>
                        {l s='Log in'}
                    </span>
                    </button>
                </div>
            </form>

            <hr class="btn-block" />
            <form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post"
                  id="create-account_form" novalidate class="box fieldset_form">
                <h2>{l s='Sign in'}</h2>
                <div class="form_content clearfix">
                    <div class="alert alert-danger" id="general_create_account_error" style="display:none"></div>

                    <div class="form-group">
                        <input type="email" class="is_required validate account_input form-control"
                               data-validate="isEmailAvailable"
                               placeholder="{l s='Email address'}"
                               id="email_create" name="email_create"
                               value="{if isset($smarty.post.email_create)}{$smarty.post.email_create|stripslashes}{/if}"/>
                        <div id="email_create_error" class="error_message"></div>
                    </div>
                    <div class="required password form-group">
                        <span class="form_info"
                              title="{l s='Your password must be 6 caracters long'}"><span></span></span>
                        <input type="password" class="is_required validate form-control"
                               data-validate="isPasswd1"
                               placeholder="{l s='Password'}"
                               name="passwd1"
                               id="passwd1"/>
                        <div id="passwd1_error" class="error_message"></div>
                    </div>
                    <div class="required password form-group">
                        <input type="password" class="is_required form-control" data-validate="isPasswd2"
                               name="passwd2" placeholder="{l s='Repeat password'}"
                               id="passwd2"/>
                        <div id="passwd2_error" class="error_message"></div>
                    </div>
                    <div>
                        <input type="checkbox" name="ckb_newsletter" id="ckb_newsletter"/>
                        <label id="ckb_newsletter"
                               for="ckb_newsletter"><span></span>{l s='The super Mon Pot Pourri\'s newsletter? Yes.'}
                        </label>
                    </div>

                    {*{$HOOK_CREATE_ACCOUNT_FORM}*}
                </div>
                <div class="text-center">
                    <br/>
                    {if isset($back)}<input type="hidden" class="hidden" name="back"
                                            value="{$back|escape:'html':'UTF-8'}" />{/if}
                    <button type="submit"
                            id="SubmitCreate"
                            name="SubmitCreate"
                            class="btn btn-default btn-block">
                    <span>
                        {l s='I create my account'}
                    </span>
                    </button>
                    <input type="hidden" class="hidden" name="SubmitCreate" value="{l s='Create my account'}"/>
                    <span id="create_success">{l s='Congratulations! Your account has been created.'}</span>
                </div>
            </form>
        </div>
        <div class="auth-boxes">
            <form class="box" style="visibility: hidden;"></form>
            <form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post"
                  id="complete-account_form" class="box fieldset_form">
                <div class="form_content clearfix">
                    <h2 class="page-subheading">{l s='We are curious : tell us more !'}</h2>
                    <div class="alert alert-danger" id="complete_account_error" style="display:none"></div>

                    <div class="gender_form row">
                        {foreach from=$genders key=k item=gender}
                            <div class="col-xs-4">
                            <input type="radio" name="id_gender" id="id_gender{$k}" value="{$k|intval}"
                                   {if isset($smarty.post.id_gender) && $smarty.post.id_gender == $k || $customer_gender == $k|intval}checked="checked"{/if} />
                            <label for="id_gender{$k}" class="top"><span></span>{$gender}</label>
                            </div>
                        {/foreach}
                        <div id="gender_complete_error" class="error_message"></div>
                    </div>
                    <div class="form-group">
                        <input type="text" class="validate form-control"
                               data-validate="isName" id="lastname_complete"
                               placeholder="{l s='Last name'}"
                               name="lastname_complete"/>
                        <div id="lastname_complete_error" class="error_message"></div>
                    </div>
                    <div class="form-group">
                        <input type="text" class="validate form-control"
                               data-validate="isName" id="firstname_complete"
                               placeholder="{l s='First name'}"
                               name="firstname_complete"/>
                        <div id="firstname_complete_error" class="error_message"></div>
                    </div>
                    <div class="form-group">
                        <input type="text" class="validate form-control autocomplete_address"
                               data-validate="isAddress" id="address_complete"
                               placeholder="{l s='Address'}"
                               name="address_complete"/>
                        <div id="address_complete_error" class="error_message"></div>
                    </div>
                    <div class="form-group postal_code_fieldset">
                        <input type="text" class="validate form-control"
                               data-validate="isNumber" id="postal_code"
                               placeholder="{l s='Zip Code'}"
                               name="postal_code"/>
                    </div>
                    <div class="form-group country_fieldset">
                        <input type="text" class="validate form-control"
                               data-validate="isName" id="locality"
                               placeholder="{l s='City'}"
                               name="locality"/>
                    </div>
                    <div id="postal_code_error" class="error_message"></div>
                    <div id="locality_error" class="error_message"></div>
                    <div class="form-group">
                        <input type="text" class="validate form-control"
                               data-validate="isName" id="country"
                               placeholder="{l s='Country'}"
                               name="country"/>
                        <div id="country_error" class="error_message"></div>
                    </div>
                </div>

                <div class="text-center">
                    {if isset($back)}<input type="hidden" class="hidden" name="back"
                                            value="{$back|escape:'html':'UTF-8'}" />{/if}
                    <input type="hidden" class="hidden" name="address_alias" value="{l s='Default address'}"/>

                    <button type="submit"
                            id="SubmitComplete"
                            name="SubmitComplete"
                            class="btn btn-default btn-block">
                    <span>
                        {l s='Validate'}
                    </span>
                    </button>
                </div>
                <div class="text-right">
                    <button id="mystery" class="btn btn-info light-tooltip"
                            title="{l s='You can complete your personal information any time from your customer area.'}" data-toggle="tooltip" data-placement="bottom"
                            data-href="{$link->getPageLink('my-account')|escape:'html':'UTF-8'}">{l s='Je complèterai plus tard...'}
                    </button>
                    <input type="hidden" class="hidden" name="SubmitComplete" value="{l s='Validate'}"/>
                </div>
            </form>
        </div>
    </div>
    {if isset($inOrderProcess) && $inOrderProcess && $PS_GUEST_CHECKOUT_ENABLED}
        {*<form action="{$link->getPageLink('authentication', true, NULL, "back=$back")|escape:'html':'UTF-8'}"
              method="post" id="new_account_form" class="std clearfix">
            <div class="box">
                <div id="opc_account_form" style="display: block; ">
                    <h3 class="page-heading bottom-indent">{l s='Instant checkout'}</h3>
                    <p class="required"><sup>*</sup>{l s='Required field'}</p>
                    <!-- Account -->
                    <div class="required form-group">
                        <label for="guest_email">{l s='Email address'} <sup>*</sup></label>
                        <input type="text" class="is_required validate form-control" data-validate="isEmail"
                               id="guest_email" name="guest_email"
                               value="{if isset($smarty.post.guest_email)}{$smarty.post.guest_email}{/if}"/>
                    </div>
                    <div class="cleafix gender-line">
                        <label>{l s='Title'}</label>
                        {foreach from=$genders key=k item=gender}
                            <div class="radio-inline">
                                <label for="id_gender{$gender->id}" class="top">
                                    <input type="radio" name="id_gender" id="id_gender{$gender->id}"
                                           value="{$gender->id}"{if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id} checked="checked"{/if} />
                                    {$gender->name}
                                </label>
                            </div>
                        {/foreach}
                    </div>
                    <div class="required form-group">
                        <label for="firstname">{l s='First name'} <sup>*</sup></label>
                        <input type="text" class="is_required validate form-control" data-validate="isName"
                               id="firstname" name="firstname"
                               value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}"/>
                    </div>
                    <div class="required form-group">
                        <label for="lastname">{l s='Last name'} <sup>*</sup></label>
                        <input type="text" class="is_required validate form-control" data-validate="isName"
                               id="lastname" name="lastname"
                               value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}"/>
                    </div>
                    <div class="form-group date-select">
                        <label>{l s='Date of Birth'}</label>
                        <div class="row">
                            <div class="col-xs-4">
                                <select id="days" name="days" class="form-control">
                                    <option value="">-</option>
                                    {foreach from=$days item=day}
                                        <option value="{$day}" {if ($sl_day == $day)} selected="selected"{/if}>{$day}
                                            &nbsp;&nbsp;</option>
                                    {/foreach}
                                </select>*}
        {*
            {l s='January'}
            {l s='February'}
            {l s='March'}
            {l s='April'}
            {l s='May'}
            {l s='June'}
            {l s='July'}
            {l s='August'}
            {l s='September'}
            {l s='October'}
            {l s='November'}
            {l s='December'}
            *}
        {*
                            </div>
                            <div class="col-xs-4">
                                <select id="months" name="months" class="form-control">
                                    <option value="">-</option>
                                    {foreach from=$months key=k item=month}
                                        <option value="{$k}" {if ($sl_month == $k)} selected="selected"{/if}>{l s=$month}
                                            &nbsp;</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-xs-4">
                                <select id="years" name="years" class="form-control">
                                    <option value="">-</option>
                                    {foreach from=$years item=year}
                                        <option value="{$year}" {if ($sl_year == $year)} selected="selected"{/if}>{$year}
                                            &nbsp;&nbsp;</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                    {if isset($newsletter) && $newsletter}
                        <div class="checkbox">
                            <label for="newsletter">
                                <input type="checkbox" name="newsletter" id="newsletter" value="1"
                                       {if isset($smarty.post.newsletter) && $smarty.post.newsletter == '1'}checked="checked"{/if} />
                                {l s='Sign up for our newsletter!'}</label>
                        </div>
                    {/if}
                    {if isset($optin) && $optin}
                        <div class="checkbox">
                            <label for="optin">
                                <input type="checkbox" name="optin" id="optin" value="1"
                                       {if isset($smarty.post.optin) && $smarty.post.optin == '1'}checked="checked"{/if} />
                                {l s='Receive special offers from our partners!'}</label>
                        </div>
                    {/if}
                    <h3 class="page-heading bottom-indent top-indent">{l s='Delivery address'}</h3>
                    {foreach from=$dlv_all_fields item=field_name}
                        {if $field_name eq "company"}
                            <div class="form-group">
                                <label for="company">{l s='Company'}{if in_array($field_name, $required_fields)}
                                        <sup>*</sup>
                                    {/if}</label>
                                <input type="text" class="form-control" id="company" name="company"
                                       value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}"/>
                            </div>
                        {elseif $field_name eq "vat_number"}
                            <div id="vat_number" style="display:none;">
                                <div class="form-group">
                                    <label for="vat-number">{l s='VAT number'}{if in_array($field_name, $required_fields)}
                                            <sup>*</sup>
                                        {/if}</label>
                                    <input id="vat-number" type="text" class="form-control" name="vat_number"
                                           value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{/if}"/>
                                </div>
                            </div>
                        {elseif $field_name eq "dni"}
                            {assign var='dniExist' value=true}
                            <div class="required dni form-group">
                                <label for="dni">{l s='Identification number'} <sup>*</sup></label>
                                <input type="text" name="dni" id="dni"
                                       value="{if isset($smarty.post.dni)}{$smarty.post.dni}{/if}"/>
                                <span class="form_info">{l s='DNI / NIF / NIE'}</span>
                            </div>
                        {elseif $field_name eq "address1"}
                            <div class="required form-group">
                                <label for="address1">{l s='Address'} <sup>*</sup></label>
                                <input type="text" class="form-control" name="address1" id="address1"
                                       value="{if isset($smarty.post.address1)}{$smarty.post.address1}{/if}"/>
                            </div>
                        {elseif $field_name eq "address2"}
                            <div class="form-group is_customer_param">
                                <label for="address2">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)}
                                        <sup>*</sup>
                                    {/if}</label>
                                <input type="text" class="form-control" name="address2" id="address2"
                                       value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}"/>
                            </div>
                        {elseif $field_name eq "postcode"}
                            {assign var='postCodeExist' value=true}
                            <div class="required postcode form-group">
                                <label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
                                <input type="text" class="validate form-control" name="postcode" id="postcode"
                                       data-validate="isPostCode"
                                       value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}"/>
                            </div>
                        {elseif $field_name eq "city"}
                            <div class="required form-group">
                                <label for="city">{l s='City'} <sup>*</sup></label>
                                <input type="text" class="form-control" name="city" id="city"
                                       value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}"/>
                            </div>
                            <!-- if customer hasn't update his layout address, country has to be verified but it's deprecated -->
                        {elseif $field_name eq "Country:name" || $field_name eq "country"}
                            <div class="required select form-group">
                                <label for="id_country">{l s='Country'} <sup>*</sup></label>
                                <select name="id_country" id="id_country" class="form-control">
                                    {foreach from=$countries item=v}
                                        <option value="{$v.id_country}"{if (isset($smarty.post.id_country) AND  $smarty.post.id_country == $v.id_country) OR (!isset($smarty.post.id_country) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        {elseif $field_name eq "State:name"}
                            {assign var='stateExist' value=true}
                            <div class="required id_state select form-group">
                                <label for="id_state">{l s='State'} <sup>*</sup></label>
                                <select name="id_state" id="id_state" class="form-control">
                                    <option value="">-</option>
                                </select>
                            </div>
                        {/if}
                    {/foreach}
                    {if $stateExist eq false}
                        <div class="required id_state select unvisible form-group">
                            <label for="id_state">{l s='State'} <sup>*</sup></label>
                            <select name="id_state" id="id_state" class="form-control">
                                <option value="">-</option>
                            </select>
                        </div>
                    {/if}
                    {if $postCodeExist eq false}
                        <div class="required postcode unvisible form-group">
                            <label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
                            <input type="text" class="validate form-control" name="postcode" id="postcode"
                                   data-validate="isPostCode"
                                   value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}"/>
                        </div>
                    {/if}
                    {if $dniExist eq false}
                        <div class="required form-group dni">
                            <label for="dni">{l s='Identification number'} <sup>*</sup></label>
                            <input type="text" class="text form-control" name="dni" id="dni"
                                   value="{if isset($smarty.post.dni) && $smarty.post.dni}{$smarty.post.dni}{/if}"/>
                            <span class="form_info">{l s='DNI / NIF / NIE'}</span>
                        </div>
                    {/if}
                    <div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
                        <label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least}
                                <sup>*</sup>
                            {/if}</label>
                        <input type="text" class="form-control" name="phone_mobile" id="phone_mobile"
                               value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{/if}"/>
                    </div>
                    <input type="hidden" name="alias" id="alias" value="{l s='My address'}"/>
                    <input type="hidden" name="is_new_customer" id="is_new_customer" value="0"/>
                    <div class="checkbox">
                        <label for="invoice_address">
                            <input type="checkbox" name="invoice_address"
                                   id="invoice_address"{if (isset($smarty.post.invoice_address) && $smarty.post.invoice_address) || (isset($smarty.post.invoice_address) && $smarty.post.invoice_address)} checked="checked"{/if}
                                   autocomplete="off"/>
                            {l s='Please use another address for invoice'}</label>
                    </div>
                    <div id="opc_invoice_address" class="unvisible">
                        {assign var=stateExist value=false}
                        {assign var=postCodeExist value=false}
                        {assign var=dniExist value=false}
                        <h3 class="page-subheading top-indent">{l s='Invoice address'}</h3>
                        {foreach from=$inv_all_fields item=field_name}
                            {if $field_name eq "company"}
                                <div class="form-group">
                                    <label for="company_invoice">{l s='Company'}{if in_array($field_name, $required_fields)}
                                            <sup>*</sup>
                                        {/if}</label>
                                    <input type="text" class="text form-control" id="company_invoice"
                                           name="company_invoice"
                                           value="{if isset($smarty.post.company_invoice) && $smarty.post.company_invoice}{$smarty.post.company_invoice}{/if}"/>
                                </div>
                            {elseif $field_name eq "vat_number"}
                                <div id="vat_number_block_invoice" style="display:none;">
                                    <div class="form-group">
                                        <label for="vat_number_invoice">{l s='VAT number'}{if in_array($field_name, $required_fields)}
                                                <sup>*</sup>
                                            {/if}</label>
                                        <input type="text" class="form-control" id="vat_number_invoice"
                                               name="vat_number_invoice"
                                               value="{if isset($smarty.post.vat_number_invoice) && $smarty.post.vat_number_invoice}{$smarty.post.vat_number_invoice}{/if}"/>
                                    </div>
                                </div>
                            {elseif $field_name eq "dni"}
                                {assign var=dniExist value=true}
                                <div class="required form-group dni_invoice">
                                    <label for="dni_invoice">{l s='Identification number'} <sup>*</sup></label>
                                    <input type="text" class="text form-control" name="dni_invoice" id="dni_invoice"
                                           value="{if isset($smarty.post.dni_invoice) && $smarty.post.dni_invoice}{$smarty.post.dni_invoice}{/if}"/>
                                    <span class="form_info">{l s='DNI / NIF / NIE'}</span>
                                </div>
                            {elseif $field_name eq "firstname"}
                                <div class="required form-group">
                                    <label for="firstname_invoice">{l s='First name'} <sup>*</sup></label>
                                    <input type="text" class="form-control" id="firstname_invoice"
                                           name="firstname_invoice"
                                           value="{if isset($smarty.post.firstname_invoice) && $smarty.post.firstname_invoice}{$smarty.post.firstname_invoice}{/if}"/>
                                </div>
                            {elseif $field_name eq "lastname"}
                                <div class="required form-group">
                                    <label for="lastname_invoice">{l s='Last name'} <sup>*</sup></label>
                                    <input type="text" class="form-control" id="lastname_invoice"
                                           name="lastname_invoice"
                                           value="{if isset($smarty.post.lastname_invoice) && $smarty.post.lastname_invoice}{$smarty.post.lastname_invoice}{/if}"/>
                                </div>
                            {elseif $field_name eq "address1"}
                                <div class="required form-group">
                                    <label for="address1_invoice">{l s='Address'} <sup>*</sup></label>
                                    <input type="text" class="form-control" name="address1_invoice"
                                           id="address1_invoice"
                                           value="{if isset($smarty.post.address1_invoice) && $smarty.post.address1_invoice}{$smarty.post.address1_invoice}{/if}"/>
                                </div>
                            {elseif $field_name eq "address2"}
                                <div class="form-group is_customer_param">
                                    <label for="address2_invoice">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)}
                                            <sup>*</sup>
                                        {/if}</label>
                                    <input type="text" class="form-control" name="address2_invoice"
                                           id="address2_invoice"
                                           value="{if isset($smarty.post.address2_invoice) && $smarty.post.address2_invoice}{$smarty.post.address2_invoice}{/if}"/>
                                </div>
                            {elseif $field_name eq "postcode"}
                                {$postCodeExist = true}
                                <div class="required postcode_invoice form-group">
                                    <label for="postcode_invoice">{l s='Zip/Postal Code'} <sup>*</sup></label>
                                    <input type="text" class="validate form-control" name="postcode_invoice"
                                           id="postcode_invoice" data-validate="isPostCode"
                                           value="{if isset($smarty.post.postcode_invoice) && $smarty.post.postcode_invoice}{$smarty.post.postcode_invoice}{/if}"/>
                                </div>
                            {elseif $field_name eq "city"}
                                <div class="required form-group">
                                    <label for="city_invoice">{l s='City'} <sup>*</sup></label>
                                    <input type="text" class="form-control" name="city_invoice" id="city_invoice"
                                           value="{if isset($smarty.post.city_invoice) && $smarty.post.city_invoice}{$smarty.post.city_invoice}{/if}"/>
                                </div>
                            {elseif $field_name eq "country" || $field_name eq "Country:name"}
                                <div class="required form-group">
                                    <label for="id_country_invoice">{l s='Country'} <sup>*</sup></label>
                                    <select name="id_country_invoice" id="id_country_invoice" class="form-control">
                                        <option value="">-</option>
                                        {foreach from=$countries item=v}
                                            <option value="{$v.id_country}"{if (isset($smarty.post.id_country_invoice) && $smarty.post.id_country_invoice == $v.id_country) OR (!isset($smarty.post.id_country_invoice) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name|escape:'html':'UTF-8'}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            {elseif $field_name eq "state" || $field_name eq 'State:name'}
                                {$stateExist = true}
                                <div class="required id_state_invoice form-group" style="display:none;">
                                    <label for="id_state_invoice">{l s='State'} <sup>*</sup></label>
                                    <select name="id_state_invoice" id="id_state_invoice" class="form-control">
                                        <option value="">-</option>
                                    </select>
                                </div>
                            {/if}
                        {/foreach}
                        {if !$postCodeExist}
                            <div class="required postcode_invoice form-group unvisible">
                                <label for="postcode_invoice">{l s='Zip/Postal Code'} <sup>*</sup></label>
                                <input type="text" class="form-control" name="postcode_invoice" id="postcode_invoice"
                                       value="{if isset($smarty.post.postcode_invoice) && $smarty.post.postcode_invoice}{$smarty.post.postcode_invoice}{/if}"/>
                            </div>
                        {/if}
                        {if !$stateExist}
                            <div class="required id_state_invoice form-group unvisible">
                                <label for="id_state_invoice">{l s='State'} <sup>*</sup></label>
                                <select name="id_state_invoice" id="id_state_invoice" class="form-control">
                                    <option value="">-</option>
                                </select>
                            </div>
                        {/if}
                        {if $dniExist eq false}
                            <div class="required form-group dni_invoice">
                                <label for="dni">{l s='Identification number'} <sup>*</sup></label>
                                <input type="text" class="text form-control" name="dni_invoice" id="dni_invoice"
                                       value="{if isset($smarty.post.dni_invoice) && $smarty.post.dni_invoice}{$smarty.post.dni_invoice}{/if}"/>
                                <span class="form_info">{l s='DNI / NIF / NIE'}</span>
                            </div>
                        {/if}
                        <div class="form-group is_customer_param">
                            <label for="other_invoice">{l s='Additional information'}</label>
                            <textarea class="form-control" name="other_invoice" id="other_invoice" cols="26"
                                      rows="3"></textarea>
                        </div>
                        {if isset($one_phone_at_least) && $one_phone_at_least}
                            <p class="inline-infos required is_customer_param">{l s='You must register at least one phone number.'}</p>
                        {/if}
                        <div class="form-group is_customer_param">
                            <label for="phone_invoice">{l s='Home phone'}</label>
                            <input type="text" class="form-control" name="phone_invoice" id="phone_invoice"
                                   value="{if isset($smarty.post.phone_invoice) && $smarty.post.phone_invoice}{$smarty.post.phone_invoice}{/if}"/>
                        </div>
                        <div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
                            <label for="phone_mobile_invoice">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least}
                                    <sup>*</sup>
                                {/if}</label>
                            <input type="text" class="form-control" name="phone_mobile_invoice"
                                   id="phone_mobile_invoice"
                                   value="{if isset($smarty.post.phone_mobile_invoice) && $smarty.post.phone_mobile_invoice}{$smarty.post.phone_mobile_invoice}{/if}"/>
                        </div>
                        <input type="hidden" name="alias_invoice" id="alias_invoice"
                               value="{l s='My Invoice address'}"/>
                    </div>
                    <!-- END Account -->
                </div>
                {$HOOK_CREATE_ACCOUNT_FORM}
            </div>
            <p class="cart_navigation required submit clearfix">
                <span><sup>*</sup>{l s='Required field'}</span>
                <input type="hidden" name="display_guest_checkout" value="1"/>
                <button type="submit" class="button btn btn-default button-medium" name="submitGuestAccount"
                        id="submitGuestAccount">
                            <span>
                                {l s='Proceed to checkout'}
                                <i class="icon-chevron-right right"></i>
                            </span>
                </button>
            </p>
        </form>*}
    {/if}
    {*else*}
    {*{if isset($account_error)}
                <div class="error">
                {if {$account_error|@count} == 1}
                <p>{l s='There\'s at least one error'} :</p>
                {else}
                <p>{l s='There are %s errors' sprintf=[$account_error|@count]} :</p>
                {/if}
                <ol>
                {foreach from=$account_error item=v}
                <li>{$v}</li>
                {/foreach}
            </ol>
        </div>
        {/if}*}
    {*<form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post"
          id="account-creation_form" class="std box">
        {$HOOK_CREATE_ACCOUNT_TOP}
        <div class="account_creation">
            <h3 class="page-subheading">{l s='Your personal information'}</h3>
            <p class="required"><sup>*</sup>{l s='Required field'}</p>
            <div class="clearfix">
                <label>{l s='Title'}</label>
                <br />
                {foreach from=$genders key=k item=gender}
                <div class="radio-inline">
                    <label for="id_gender{$gender->id}" class="top">
                        <input type="radio" name="id_gender" id="id_gender{$gender->id}" value="{$gender->id}" {if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id}checked="checked"{/if} />
                        {$gender->name}
                    </label>
                </div>
                {/foreach}
            </div>
            <div class="required form-group">
                <label for="customer_firstname">{l s='First name'} <sup>*</sup></label>
                <input onkeyup="$('#firstname').val(this.value);" type="text" class="is_required validate form-control" data-validate="isName" id="customer_firstname" name="customer_firstname" value="{if isset($smarty.post.customer_firstname)}{$smarty.post.customer_firstname}{/if}" />
            </div>
            <div class="required form-group">
                <label for="customer_lastname">{l s='Last name'} <sup>*</sup></label>
                <input onkeyup="$('#lastname').val(this.value);" type="text" class="is_required validate form-control" data-validate="isName" id="customer_lastname" name="customer_lastname" value="{if isset($smarty.post.customer_lastname)}{$smarty.post.customer_lastname}{/if}" />
            </div>
            <div class="required form-group">
                <label for="email">{l s='Email'} <sup>*</sup></label>
                <input type="email" class="is_required validate form-control" data-validate="isEmail" id="email"
                       name="email" value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}"/>
            </div>
            <div class="required password form-group">
                <label for="passwd">{l s='Password'} <sup>*</sup></label>
                <input type="password" class="is_required validate form-control" data-validate="isPasswd" name="passwd"
                       id="passwd"/>
                <span class="form_info">{l s='(Five characters minimum)'}</span>
            </div>
            <div class="form-group">
                <label>{l s='Date of Birth'}</label>
                <div class="row">
                    <div class="col-xs-4">
                        <select id="days" name="days" class="form-control">
                            <option value="">-</option>
                            {foreach from=$days item=day}
                            <option value="{$day}" {if ($sl_day == $day)} selected="selected"{/if}>{$day}&nbsp;&nbsp;</option>
                            {/foreach}
                        </select>*}
    {*
        {l s='January'}
        {l s='February'}
        {l s='March'}
        {l s='April'}
        {l s='May'}
        {l s='June'}
        {l s='July'}
        {l s='August'}
        {l s='September'}
        {l s='October'}
        {l s='November'}
        {l s='December'}
        *}
    {*
                            </div>
                            <div class="col-xs-4">
                                <select id="months" name="months" class="form-control">
                                    <option value="">-</option>
                                    {foreach from=$months key=k item=month}
                                    <option value="{$k}" {if ($sl_month == $k)} selected="selected"{/if}>{l s=$month}&nbsp;</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-xs-4">
                                <select id="years" name="years" class="form-control">
                                    <option value="">-</option>
                                    {foreach from=$years item=year}
                                    <option value="{$year}" {if ($sl_year == $year)} selected="selected"{/if}>{$year}&nbsp;&nbsp;</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
            {if isset($newsletter) && $newsletter}
                <div class="checkbox">
                    <input type="checkbox" name="newsletter" id="newsletter" value="1" {if isset($smarty.post.newsletter) AND $smarty.post.newsletter == 1} checked="checked"{/if} />
                    <label for="newsletter">{l s='Sign up for our newsletter!'}</label>
                    {if array_key_exists('newsletter', $field_required)}
                    <sup> *</sup>
                    {/if}
                </div>
            {/if}
            {if isset($optin) && $optin}
                {*<div class="checkbox">
                    <input type="checkbox" name="optin" id="optin" value="1" {if isset($smarty.post.optin) AND $smarty.post.optin == 1} checked="checked"{/if} />
                    <label for="optin">{l s='Receive special offers from our partners!'}</label>
                    {if array_key_exists('optin', $field_required)}
                    <sup> *</sup>
                    {/if}
                </div>
            {/if}
        </div>
        *}
    {*{if $b2b_enable}
        <div class="account_creation">
            <h3 class="page-subheading">{l s='Your company information'}</h3>
            <p class="form-group">
                <label for="">{l s='Company'}</label>
                <input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}" />
            </p>
            <p class="form-group">
                <label for="siret">{l s='SIRET'}</label>
                <input type="text" class="form-control" id="siret" name="siret" value="{if isset($smarty.post.siret)}{$smarty.post.siret}{/if}" />
            </p>
            <p class="form-group">
                <label for="ape">{l s='APE'}</label>
                <input type="text" class="form-control" id="ape" name="ape" value="{if isset($smarty.post.ape)}{$smarty.post.ape}{/if}" />
            </p>
            <p class="form-group">
                <label for="website">{l s='Website'}</label>
                <input type="text" class="form-control" id="website" name="website" value="{if isset($smarty.post.website)}{$smarty.post.website}{/if}" />
            </p>
        </div>
    {/if}*}
    {*{if isset($PS_REGISTRATION_PROCESS_TYPE) && $PS_REGISTRATION_PROCESS_TYPE}
        <div class="account_creation">
            <h3 class="page-subheading">{l s='Your address'}</h3>
            {foreach from=$dlv_all_fields item=field_name}
            {if $field_name eq "company"}
            {if !$b2b_enable}
            <p class="form-group">
                <label for="company">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
                <input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}" />
            </p>
            {/if}
            {elseif $field_name eq "vat_number"}
            <div id="vat_number" style="display:none;">
                <p class="form-group">
                    <label for="vat_number">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
                    <input type="text" class="form-control" id="vat_number" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{/if}" />
                </p>
            </div>
            {elseif $field_name eq "firstname"}
            <p class="required form-group">
                <label for="firstname">{l s='First name'} <sup>*</sup></label>
                <input type="text" class="form-control" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}" />
            </p>
            {elseif $field_name eq "lastname"}
            <p class="required form-group">
                <label for="lastname">{l s='Last name'} <sup>*</sup></label>
                <input type="text" class="form-control" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}" />
            </p>
            {elseif $field_name eq "address1"}
            <p class="required form-group">
                <label for="address1">{l s='Address'} <sup>*</sup></label>
                <input type="text" class="form-control" name="address1" id="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{/if}" />
                <span class="inline-infos">{l s='Street address, P.O. Box, Company name, etc.'}</span>
            </p>
            {elseif $field_name eq "address2"}
            <p class="form-group is_customer_param">
                <label for="address2">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
                <input type="text" class="form-control" name="address2" id="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}" />
                <span class="inline-infos">{l s='Apartment, suite, unit, building, floor, etc...'}</span>
            </p>
            {elseif $field_name eq "postcode"}
            {assign var='postCodeExist' value=true}
            <p class="required postcode form-group">
                <label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
                <input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}"/>
            </p>
            {elseif $field_name eq "city"}
            <p class="required form-group">
                <label for="city">{l s='City'} <sup>*</sup></label>
                <input type="text" class="form-control" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}" />
            </p>
            <!-- if customer hasn't update his layout address, country has to be verified but it's deprecated -->
            {elseif $field_name eq "Country:name" || $field_name eq "country"}
            <p class="required select form-group">
                <label for="id_country">{l s='Country'} <sup>*</sup></label>
                <select name="id_country" id="id_country" class="form-control">
                    <option value="">-</option>
                    {foreach from=$countries item=v}
                    <option value="{$v.id_country}"{if (isset($smarty.post.id_country) AND $smarty.post.id_country == $v.id_country) OR (!isset($smarty.post.id_country) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name}</option>
                    {/foreach}
                </select>
            </p>
            {elseif $field_name eq "State:name" || $field_name eq 'state'}
            {assign var='stateExist' value=true}
            <p class="required id_state select form-group">
                <label for="id_state">{l s='State'} <sup>*</sup></label>
                <select name="id_state" id="id_state" class="form-control">
                    <option value="">-</option>
                </select>
            </p>
            {/if}
            {/foreach}
            {if $postCodeExist eq false}
            <p class="required postcode form-group unvisible">
                <label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
                <input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}"/>
            </p>
            {/if}
            {if $stateExist eq false}
            <p class="required id_state select unvisible form-group">
                <label for="id_state">{l s='State'} <sup>*</sup></label>
                <select name="id_state" id="id_state" class="form-control">
                    <option value="">-</option>
                </select>
            </p>
            {/if}
            <p class="textarea form-group">
                <label for="other">{l s='Additional information'}</label>
                <textarea class="form-control" name="other" id="other" cols="26" rows="3">{if isset($smarty.post.other)}{$smarty.post.other}{/if}</textarea>
            </p>
            <p class="form-group">
                <label for="phone">{l s='Home phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
                <input type="text" class="form-control" name="phone" id="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{/if}" />
            </p>
            <p class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
                <label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
                <input type="text" class="form-control" name="phone_mobile" id="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{/if}" />
            </p>
            {if isset($one_phone_at_least) && $one_phone_at_least}
            {assign var="atLeastOneExists" value=true}
            <p class="inline-infos required">** {l s='You must register at least one phone number.'}</p>
            {/if}
            <p class="required form-group" id="address_alias">
                <label for="alias">{l s='Assign an address alias for future reference.'} <sup>*</sup></label>
                <input type="text" class="form-control" name="alias" id="alias" value="{if isset($smarty.post.alias)}{$smarty.post.alias}{else}{l s='My address'}{/if}" />
            </p>
        </div>
        <div class="account_creation dni">
            <h3 class="page-subheading">{l s='Tax identification'}</h3>
            <p class="required form-group">
                <label for="dni">{l s='Identification number'} <sup>*</sup></label>
                <input type="text" class="form-control" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{/if}" />
                <span class="form_info">{l s='DNI / NIF / NIE'}</span>
            </p>
        </div>
    {/if}
    {$HOOK_CREATE_ACCOUNT_FORM}
    <div class="submit clearfix">
        <input type="hidden" name="email_create" value="1"/>
        <input type="hidden" name="is_new_customer" value="1"/>
        {if isset($back)}<input type="hidden" class="hidden" name="back"
                                value="{$back|escape:'html':'UTF-8'}" />{/if}
        <button type="submit" name="submitAccount" id="submitAccount" class="btn btn-default button button-medium">
            <span>{l s='Register'}<i class="icon-chevron-right right"></i></span>
        </button>
        <p class="pull-right required"><span><sup>*</sup>{l s='Required field'}</span></p>
    </div>
    </form>
    {/if}*}
    {strip}
        {if isset($smarty.post.id_state) && $smarty.post.id_state}
            {addJsDef idSelectedState=$smarty.post.id_state|intval}
        {elseif isset($address->id_state) && $address->id_state}
            {addJsDef idSelectedState=$address->id_state|intval}
        {else}
            {addJsDef idSelectedState=false}
        {/if}
        {if isset($smarty.post.id_state_invoice) && isset($smarty.post.id_state_invoice) && $smarty.post.id_state_invoice}
            {addJsDef idSelectedStateInvoice=$smarty.post.id_state_invoice|intval}
        {else}
            {addJsDef idSelectedStateInvoice=false}
        {/if}
        {if isset($smarty.post.id_country) && $smarty.post.id_country}
            {addJsDef idSelectedCountry=$smarty.post.id_country|intval}
        {elseif isset($address->id_country) && $address->id_country}
            {addJsDef idSelectedCountry=$address->id_country|intval}
        {else}
            {addJsDef idSelectedCountry=false}
        {/if}
        {if isset($smarty.post.id_country_invoice) && isset($smarty.post.id_country_invoice) && $smarty.post.id_country_invoice}
            {addJsDef idSelectedCountryInvoice=$smarty.post.id_country_invoice|intval}
        {else}
            {addJsDef idSelectedCountryInvoice=false}
        {/if}
        {if isset($countries)}
            {addJsDef countries=$countries}
        {/if}
        {if isset($vatnumber_ajax_call) && $vatnumber_ajax_call}
            {addJsDef vatnumber_ajax_call=$vatnumber_ajax_call}
        {/if}
        {if isset($email_create) && $email_create}
            {addJsDef email_create=$email_create|boolval}
        {else}
            {addJsDef email_create=false}
        {/if}
    {/strip}
{/if}
</div>