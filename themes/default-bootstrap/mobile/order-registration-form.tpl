<div class="pull-xs-right">
    <button id="got_account"><span class="icon-exchange"></span> {l s='I already have an account'}</button>
    <button id="no_account"><span class="icon-exchange"></span> {l s='I do not have an account'}</button>
</div>
<h2>{l s='Your registration information'}</h2>
<div>
    <form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}"
          method="post"
          id="create-account_form"
          class="fieldset_form"
          novalidate>
        <div class="form_content clearfix">
            <div class="alert alert-danger" id="general_create_account_error"
                 style="display:none"></div>
            <div id="got_account_sentence">{l s='To place your first order on Mon Pot Pourri, choose your login information'}:</div>

            <div class="form-group">
                <input type="email"
                       class="is_required validate account_input form-control"
                       data-validate="isEmailAvailable"
                       placeholder="{l s='Email address'}"
                       id="email_create" name="email_create"
                       value="{if isset($smarty.post.email_create)}{$smarty.post.email_create|stripslashes}{/if}"/>
                <div id="email_create_error" class="error_message"></div>
            </div>
            <div class="required password form-group">
                <input type="password" class="is_required validate form-control"
                       data-validate="isPasswd1"
                       name="passwd1"
                       placeholder="{l s='Password'}"
                       id="passwd1"/>
                <div class="text-right">
                    <em>
                        <small>{l s='Your password must be 6 caracters long and contain at least one uppercase and one figure'}</small>
                    </em>
                </div>
                <div id="passwd1_error" class="error_message"></div>
            </div>
            <div class="required password form-group">
                <input type="password" class="is_required form-control"
                       data-validate="isPasswd2"
                       name="passwd2"
                       placeholder="{l s='Repeat password'}"
                       id="passwd2"/>
                <div id="passwd2_error" class="error_message"></div>
            </div>
            <div>
                <input type="checkbox" name="ckb_newsletter" id="ckb_newsletter"/>
                <label id="ckb_newsletter"
                       for="ckb_newsletter"><span></span>{l s='I would gladly receive monpotpourri\'s latest trends and news'}</label>
            </div>
            <div class="form-group hidden">
                <button type="submit" id="SubmitCreate" name="SubmitCreate" class="btn btn-default btn-block">
                    <span>
                        {l s='Je crée mon compte'}
                    </span>
                </button>
            </div>
        </div>
    </form>

    <form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}{if $smarty.get.content_only == '1'}?content_only=1{/if}"
          method="post"
          id="login_form" novalidate class="fieldset_form">
        <div class="alert alert-danger" id="general_login_error" style="display:none"></div>
        <div id="got_account_sentence">{l s='Do we already know each other? Log in to place your order...'}</div>
        <div class="form_content clearfix">
            <div class="form-group">
                <input class="is_required validate form-control" data-validate="isEmail"
                       type="email"
                       id="email" name="email"
                       placeholder="{l s='Email address'}"
                       value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}"/>
                <div id="email_error" class="error_message"></div>
            </div>
            <div class="form-group">
                <span class="form_info"
                      title="{l s='Your password must be 6 caracters long and contain at least one uppercase and one figure'}"><span></span></span>
                <input class="is_required validate account_input form-control"
                       type="password" placeholder="{l s='Password'}"
                       data-validate="isPasswd" id="passwd"
                       name="passwd" value=""/>
                <div id="passwd_error" class="error_message"></div>
                <div id="general_error" class="error_message"></div>
                <div class="lost_password text-right">
                    <a data-fancybox-type="iframe" href="{$link->getPageLink('password')|escape:'html':'UTF-8'}?content_only=1">{l s='Mot de passe oublié?'}</a>
                </div>
            </div>
            <div class="form-group hidden">
                {if isset($back)}<input type="hidden" class="hidden" name="back"
                                        value="{$back|escape:'html':'UTF-8'}" />{/if}
                {if isset($pid)}<input type="hidden" class="hidden" name="pid"
                                       value="{$pid|escape:'html':'UTF-8'}" />{/if}
                <button type="submit" id="SubmitLogin" name="SubmitLogin" class="btn btn-default btn-block">
                        <span>
                            {l s='Sign in'}
                        </span>
                </button>
            </div>
        </div>
    </form>
</div>