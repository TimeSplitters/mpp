<div class="row gutter-10">
    <div class="product_choice col-xs-12">
        <h4>
            <a href="#product_choice_choisir_album">
                <span class="icon-caret-down pull-xs-right"></span> <span
                        class="icon-hand"></span> <input type="radio" class="hidden" name="product_choice" value="album"
                                                         id="product_choice_album"> <label
                        for="product_choice_album">{l s='Je choisis mon album'}</label>
            </a>
        </h4>
        <div id="product_choice_choisir_album" class="row">
            <div class="form-group col-xs-12">
                <label for="album_name">{l s='Titre de l\'album souhaité'}: </label>
                <input type="text" name="album_name" id="album_name" class="form-control"/>
            </div>
        </div>
    </div>
    <div class="product_choice col-xs-12">
        <h4>
            <a href="#product_choice_surprise">
                <span class="icon-caret-down pull-xs-right"></span> <span
                        class="icon-gift"></span> <input type="radio" class="hidden" name="product_choice" value="surprise"
                                                         id="product_choice_questionnaire"> <label
                        for="product_choice_questionnaire">{l s='Je vous laisse choisir'}</label>
            </a>
        </h4>
        <div id="product_choice_surprise" class="row">
            <div class="col-xs-12">
                <div>{l s='Nous choisissons pour vous le meilleur album selon les critères suivants :'} </div>
                <h5>{l s='Vous êtes :'}</h5>
                <input type="radio" name="gender" value="Un homme" id="gender_homme"/> <label
                        for="gender_homme">{l s='Un homme'}</label>
                <br/>
                <input type="radio" name="gender" value="Une femme" id="gender_femme"/> <label
                        for="gender_femme">{l s='Une femme'}</label>

                <h5>{l s='Vous avez entre :'}</h5>
                <div class="row gutter-10">
                    <div class="col-xs-6">
                        <input type="radio" name="age_range" value="13-17 ans" id="age_13-17"/>
                        <label
                                for="age_13-17">{l s='13-17 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="18-24 ans" id="age_18-24"/>
                        <label
                                for="age_18-24">{l s='18-24 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="25-34 ans" id="age_25-34"/>
                        <label
                                for="age_25-34">{l s='25-34 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="35-44 ans" id="age_35-44"/>
                        <label
                                for="age_35-44">{l s='35-44 ans'}</label>
                    </div>
                    <div class="col-xs-6">
                        <input type="radio" name="age_range" value="45-54 ans" id="age_45-54"/>
                        <label
                                for="age_45-54">{l s='45-54 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="55-64 ans" id="age_55-64"/>
                        <label
                                for="age_55-64">{l s='55-64 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="65+" id="age_65"/> <label
                                for="age_65">{l s='65+'}</label>
                    </div>
                </div>
                <h5>{l s='Quel genre souhaitez-vous ?'}</h5>
                <input type="radio" name="genre" value="Pop"
                       id="pop"/> <label
                        for="pop">{l s='Pop'}</label>
                <br/>
                <input type="radio" name="genre" value="Rock"
                       id="rock"/> <label
                        for="rock">{l s='Rock'}</label>
                <br/>
                <input type="radio" name="genre" value="Jazz" id="jazz"/> <label
                        for="jazz">{l s='Jazz'}</label>
                <br/>
                <input type="radio" name="genre" value="Hip Hop / Rap / Slam"
                       id="hiphop"/> <label
                        for="hiphop">{l s='Hip Hop / Rap / Slam'}</label>
                <br/>
                <input type="radio" name="genre" value="R'n'B" id="rnb"/>
                <label for="rnb">{l s='R\'n\'B'}</label>
                <br/>
                <input type="radio" name="genre"
                       value="Electro"
                       id="electro"/> <label
                        for="electro">{l s='Electro'}</label>
                <br/>
                <input type="radio" name="genre" value="Classique / Opéra" id="classique_opera"/> <label
                        for="classique_opera">{l s='Classique / Opéra'}</label>
                <br/>
                <input type="radio" name="genre" value="Musique latine" id="latine"/>
                <label for="latine">{l s='Musique latine'}</label>

                <br/>
                <input type="radio" name="genre" value="Musique africaine / maghrébine" id="africa"/>
                <label for="africa">{l s='Musique africaine / maghrébine'}</label>

                <br/>
                <input type="radio" name="genre" value="Jpop / Kpop" id="asia"/>
                <label for="asia">{l s='Jpop / Kpop'}</label>

                <br/>
                <input type="radio" name="genre" value="Bollywood" id="bollywood"/>
                <label for="bollywood">{l s='Bollywood'}</label>

                <br/>
                <input type="radio" name="genre" value="Musique de films" id="musique_film"/>
                <label for="musique_film">{l s='Musique de films'}</label>
                <br/>

                <h5>{l s='Précisez-nous l\'année de sortie désirée ?'}</h5>

                <input type="radio" name="year" value="1920-1939"
                       id="twenties_thirties"/> <label
                        for="twenties_thirties">{l s='1920-1939'}</label>
                <br/>

                <input type="radio" name="year" value="1940-1959"
                       id="fourties_fifties"/> <label
                        for="fourties_fifties">{l s='1940-1959'}</label>
                <br/>

                <input type="radio" name="year" value="1960-1979"
                       id="sixties_seventies"/> <label
                        for="sixties_seventies">{l s='1960-1979'}</label>
                <br/>

                <input type="radio" name="year" value="Années 80"
                       id="eighties"/> <label
                        for="eighties">{l s='Années 80'}</label>
                <br/>

                <input type="radio" name="year" value="Années 90"
                       id="nineties"/> <label
                        for="nineties">{l s='Années 90'}</label>
                <br/>

                <input type="radio" name="year" value="Années 2000 à nos jours"
                       id="millenium"/> <label
                        for="millenium">{l s='Années 2000 à nos jours'}</label>
                <br/>

                <input type="radio" name="year" value="Pas de préférence"
                       id="no_preference"/> <label
                        for="no_preference">{l s='Pas de préférence'}</label>
                <br/>


                <h5>{l s='Précisez-nous ce que vous attendez d\'écouter :'}</h5>
                <small>{l s='Précision du genre, du style, de l\'année, etc... (30 caractères min.)'}</small>
                <textarea name="description_attentes"></textarea>

                <br/>

                <h5>{l s='Avez-vous déjà écouté des CDs dans ce genre-là ?'}</h5>
                <small>{l s='Si oui, le(s)quel(s) et qu\'en avez-vous pensé ? (30 caractères min.)'}</small>
                <textarea name="description_attentes"></textarea>

                <br/>

                <h5>{l s='Voulez-vous que l\'on vous soumette notre choix ?'}</h5>
                <input type="radio" name="soumission_choix"
                       value="Oui, je souhaite valider le choix" id="soumission_oui"/>
                <label for="soumission_oui">{l s='Oui, je souhaite valider le choix'}</label>

                <br/>
                <input type="radio" name="soumission_choix" value="Non, surprenez-moi !"
                       id="soumission_non"/>
                <label for="soumission_non">{l s='Non, surprenez-moi !'}</label>
                <hr/>
            </div>
        </div>
    </div>
</div>