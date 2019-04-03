<?php
define('__ROOT__', dirname(dirname(dirname(__FILE__)))); 
require_once(__ROOT__.'/config.php');

class SigninCest
{
    public function loginSuccessfully(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->waitForElement('._facebookButton', 20); // secs
        $I->click('._facebookButton');

        $I->wait(2);
        $I->switchToNextTab();
        $I->fillField('#email', EMAIL);
        $I->fillField('#pass', PASS);
        $I->click('#loginbutton');

        $I->wait(2);
        $I->switchToWindow();
        $I->click('Allow');
        $I->wait(2);
        $I->click('Not interested');

        for ($i = 0; $i < 20; ++$i) {
            
            $I->wait(2);
            // trata exceções
            if($i == 6){
                $I->see('Not interested');
                $I->click('Not interested');
            }

            echo 'step '.$i;
            $I->seeElement('.recsGamepad__button:nth-child(4)');
            $I->click('.recsGamepad__button:nth-child(4)');
        }
    }
}
