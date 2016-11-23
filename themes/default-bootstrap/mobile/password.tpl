<div class="col-xs-12 col-sm-12">
{capture name=path}
    <a href="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}"
       title="{l s='Authentication'}" rel="nofollow">{l s='Authentication'}</a>
    <span class="navigation-pipe">{$navigationPipe}</span>{l s='Forgot your password'}
{/capture}
<div class="box">
    {*<h1 class="page-subheading">{l s='Forgot your password?'}</h1>*}

    {if !isset($confirmation)}

        <form action="{$request_uri|escape:'html':'UTF-8'}" method="post" class="std fieldset_form" id="form_forgotpassword"
              novalidate>
            <h2>{l s='Forgot your password?'}</h2>
            <div>{l s='Please enter the email address you used to register with.'}<br />{l s='We will then send you a mail to change your password.'}</div>
            <div class="form_content clearfix">
                <div class="required password form-group">
                    <input class="is_required validate form-control"
                           type="email" id="email" name="email"
                           placeholder="{l s='Email address'}"
                           data-validate="isEmail"/>
                    <input type="hidden" id="message" name="message" value="{$smarty.get.message}" />
                    <div id="email_error" class="error_message">{$errors.email_error}</div>
                </div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-default">
                    {l s='Reset my password'}
                </button>
            </div>
            <div id="forgot_password_success">{l s='We have sent you an email. Check your inbox to change your password.'}</div>
        </form>
    {elseif $confirmation == 'changeAvailable'}
        <form action="{$link->getPageLink('password', true)|escape:'html':'UTF-8'}?email_token={$smarty.get.email_token}&id_customer={$smarty.get.id_customer}"
              method="post" id="change-password_form" novalidate class="fieldset_form">
            <div>{l s='Please choose your new password, and write it again'} :</div>
            <div class="form_content clearfix">
                <div class="required password form-group">
                    <fieldset>
                        <legend><label id="label_passwd1" for="passwd1">{l s='Password'}<span class="form_info"
                                                                                              title="{l s='Your password must be 6 caracters long and contain at least one uppercase and one figure'}"></span></label>
                        </legend>
                        <input type="password" class="is_required validate form-control"
                               data-validate="isPasswd1"
                               name="passwd1"
                               id="passwd1"/>
                    </fieldset>
                    <div id="passwd1_error" class="error_message"></div>
                </div>
                <div class="required password form-group">
                    <fieldset>
                        <legend><label id="label_passwd2" for="passwd2">{l s='Repeat password'}</label></legend>
                        <input type="password" class="is_required form-control" data-validate="isPasswd2"
                               name="passwd2"
                               id="passwd2"/>
                    </fieldset>
                    <div id="passwd2_error" class="error_message"></div>
                </div>

                <div class="text-center">
                    {if isset($back)}
                        <input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}"/>
                    {/if}
                    <button type="submit" id="SubmitChangePassword" name="SubmitChangePassword" class="btn btn-default">
                        <span>
                            {l s='Validate'}
                        </span>
                    </button>
                    <input type="hidden" class="hidden" name="SubmitChangePassword"
                           value="{l s='Validate'}"/>
                    <input type="hidden" class="hidden" name="hidden_token"
                           value="{$smarty.get.email_token}"/>
                    <input type="hidden" class="hidden" name="hidden_id_customer"
                           value="{$smarty.get.id_customer}"/>
                    <input type="hidden" class="hidden" name="url_redirect"
                           value="{if $smarty.get.message == 'connectToWishlist' || $smarty.get.message == 'addToWishlist'}{$link->getModuleLink('blockwishlist', 'mywishlist', array(), true)|escape:'html':'UTF-8'}{else}{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}{/if}"/>
                </div>
            </div>
            <div id="change_password_success">{l s='Your password has been successfully changed.'}</div>
        </form>
    {elseif $confirmation == 'old_token'}
        <div>{l s='This token is not available anymore. You have to ask for a new password here:'}
            <a class="back-login btn btn-default"
               href="{$link->getPageLink('password')|escape:'html':'UTF-8'}"
               rel="nofollow"><span>{l s='New password'} <i class="icon-chevron-right"></i></span></a>
        </div>
    {/if}
    <div id="general_error" class="error_message">{$errors.general_error}</div>

</div>
{*<ul class="clearfix footer_links">
    <li><a class="back-login btn btn-default"
           href="{$link->getPageLink('authentication')|escape:'html':'UTF-8'}"
           rel="nofollow"><span><i class="icon-chevron-left"></i>{l s='Back to Login'}</span></a></li>
</ul>
*}
</div>