<div class="col-xs-12 col-sm-12">
    {capture name=path}
    <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
        {l s='My account'}
    </a>
    <span class="navigation-pipe">
        {$navigationPipe}
    </span>
    <span class="navigation_page">
        {l s='My information'}
    </span>
{/capture}
<div class="page-header">
    <div>
        <div id="accordion" class="panel-group">
            <!-- INFOS -->
            {include file="{$tpl_dir}mobile/espace_client_sublinks.tpl" titleAccordion={l s='Mes infos'}}
        </div>
    </div>
    {include file="{$tpl_dir}mobile/my-account-add-address.tpl"}
    <div class="clearfix"></div>
</div>
<div>
    <div id="my-account-identity-tabs" class="usual">
        <div id="tab-identity">
            <h5 class="page-subheading">{l s='Mes informations personnelles'}</h5>
            <form action="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}" method="post"
                  class="std fieldset_form">
                <div class="identity-info-blocks">
                    <div class="gender_form">
                        {foreach from=$genders key=k item=gender}
                            <div>
                                <input type="radio" name="id_gender" id="id_gender{$k}" value="{$k|intval}"
                                   {if isset($smarty.post.id_gender) && $smarty.post.id_gender == $k || $customer_gender == $k|intval}checked="checked"{/if} />
                                <label for="id_gender{$k}" class="top"><span></span>{$gender}</label>
                            </div>
                        {/foreach}
                    </div>
                    <div id="gender_error" class="error_message"></div>
                    <div class="form-group">
                        <input class="validate form-control" data-validate="isName"
                               type="text" name="lastname"
                               placeholder="{l s='Last name'}"
                               id="lastname" value="{$smarty.post.lastname}"/>
                        <div id="lastname_error" class="error_message"></div>
                    </div>
                    <div class="form-group">
                        <input class="validate form-control" data-validate="isName"
                               type="text" id="firstname"
                               placeholder="{l s='First name'}"
                               name="firstname" value="{$smarty.post.firstname}"/>
                        <div id="firstname_error" class="error_message"></div>
                    </div>
                    <div class="form-group">
                        <div>{l s='Date of Birth'}</div>
                        <div class="row gutter-10">
                            <div class="col-xs-4">
                                <input class="validate form-control" type="number"
                                       data-validate="isDayOfMonth"
                                       placeholder="{l s='Day'}"
                                       name="days" id="days" min="1"
                                       max="31" value="{if $sl_day > 0}{$sl_day}{/if}"/>
                            </div>
                            <div class="col-xs-4">
                                <input class="validate form-control" type="number"
                                       data-validate="isMonthNumber"
                                       placeholder="{l s='Month'}"
                                       name="months" id="months"
                                       min="1" max="12"
                                       value="{if $sl_month > 0}{$sl_month}{/if}"/>
                            </div>
                            <div class="col-xs-4">
                                <input class="validate form-control" type="number"
                                       data-validate="isYear"
                                       name="years" id="years"
                                       placeholder="{l s='Year'}"
                                       min="1900" max="2016"
                                       value="{if $sl_year > 0}{$sl_year}{/if}"/>
                            </div>
                        </div>
                        <div id="birthday_error" class="error_message"></div>
                    </div>
                </div>

                <div class="identity-info-blocks form-content">
                    <h5  class="page-subheading">{l s='Email & password'}</h5>
                    <div>{l s='Change your account access here'}</div>
                    <div class="form-group{if $new_customer == 1} hidden{/if}">
                        <input class="is_required validate form-control"
                               data-validate="isEmail" type="email"
                               placeholder="{l s='Email address'}"
                               name="email" id="email" value="{$smarty.post.email}"/>
                        <div id="email_error" class="error_message"></div>
                    </div>
                    <div class="form-group{if $new_customer == 1} hidden{/if}">
                        <input class="validate form-control" type="password"
                               data-validate="isPasswd"
                               placeholder="{l s='Current Password'}"
                               name="old_passwd" id="old_passwd"/>
                        <div id="old_passwd_error" class="error_message"></div>
                    </div>
                    <div class="password form-group{if $new_customer == 1} hidden{/if}">
                        <input class="validate form-control" type="password"
                               data-validate="isPasswd" name="passwd"
                               placeholder="{l s='New Password'}"
                               id="passwd"/>
                        <div class="text-right">
                            <small><em>{l s='Your password must be 6 caracters long'}</em></small>
                        </div>
                    </div>
                    <div class="password form-group">
                        <input class="validate form-control" type="password"
                               data-validate="isPasswd" name="passwd2"
                               placeholder="{l s='Confirmation'}"
                               id="passwd2"/>
                        <div id="passwd2_error" class="error_message"></div>
                    </div>
                    {if isset($HOOK_CUSTOMER_IDENTITY_FORM)}
                        {$HOOK_CUSTOMER_IDENTITY_FORM}
                    {/if}
                </div>

                {if isset($newsletter) && $newsletter}
                    <h5 class="page-subheading">{l s='Newsletter monpotpourri'}</h5>
                    <div class="checkbox">
                        <input type="radio" name="newsletter" id="newsletter1"
                               value="1" {if isset($smarty.post.newsletter) && $smarty.post.newsletter == 1 || $customer_newsletter == 1} checked="checked"{/if} />

                        <label for="newsletter1"><span></span>{l s='OUI, je souhaite recevoir la newsletter Mon Pot Pourri avec pleins d\'idées et de promotions pour mon intérieur'}
                        </label>
                        <br/>
                        <br/>
                        <input type="radio" name="newsletter" id="newsletter0"
                               value="0" {if isset($smarty.post.newsletter) && $smarty.post.newsletter != 1 || $customer_newsletter == 0} checked="checked"{/if} />

                        <label for="newsletter0"><span></span>{l s='NO, I do not want to receive the newsletter anymore'}
                        </label>
                    </div>
                {/if}
                {if isset($optin) && $optin}
                    <div class="checkbox">
                        <label for="optin">
                            <input type="checkbox" name="optin" id="optin"
                                   value="1" {if isset($smarty.post.optin) && $smarty.post.optin == 1} checked="checked"{/if}/>
                            {l s='Receive special offers from our partners!'}
                            {if isset($required_fields) && array_key_exists('optin', $field_required)}
                                <sup> *</sup>
                            {/if}
                        </label>
                    </div>
                {/if}
                {if $b2b_enable}
                    <h1 class="page-subheading">
                        {l s='Your company information'}
                    </h1>
                    <div class="form-group">
                        <label for="">{l s='Company'}</label>
                        <input type="text" class="form-control" id="company" name="company"
                               value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}"/>
                    </div>
                    <div class="form-group">
                        <label for="siret">{l s='SIRET'}</label>
                        <input type="text" class="form-control" id="siret" name="siret"
                               value="{if isset($smarty.post.siret)}{$smarty.post.siret}{/if}"/>
                    </div>
                    <div class="form-group">
                        <label for="ape">{l s='APE'}</label>
                        <input type="text" class="form-control" id="ape" name="ape"
                               value="{if isset($smarty.post.ape)}{$smarty.post.ape}{/if}"/>
                    </div>
                    <div class="form-group">
                        <label for="website">{l s='Website'}</label>
                        <input type="text" class="form-control" id="website" name="website"
                               value="{if isset($smarty.post.website)}{$smarty.post.website}{/if}"/>
                    </div>
                {/if}
                {if isset($HOOK_CUSTOMER_IDENTITY_FORM)}
                    {$HOOK_CUSTOMER_IDENTITY_FORM}
                {/if}

                <div class="text-center">
                    <button type="submit" name="submitIdentity" id="submitIdentity" class="btn btn-default btn-block">
                        <span>{l s='Save'}</span>
                    </button>
                    <br/>
                    <strong class="success_message">{l s='Your information has been saved.'}</strong>
                </div>
            </form> <!-- .std -->
        </div>
    </div>
</div>
</div>