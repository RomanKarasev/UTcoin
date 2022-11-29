//
//  Constants.swift
//  UTcoin
//
//  Created by Роман Карасёв on 22.11.2022.
//

import Foundation
import UIKit


enum Constants {
    
    enum Strings {
        static let confirmationVCTitle     = "Подтверждение телефона"
        static let confirmationInstruction = "Введите последние 4 цифры номера телефона входящего звонка. Звонок поступит на ваш номер"
        static let searchPlaceholder       = "Поиск магазинов, товаров"
        static let signInVCDescription     = "Введите номер телефона, чтобы войти или зарегистрироваться"
        static let signInVCClueLabel       = "Номер телефона"
        static let signInVCInstruction     = "(на указанный номер поступит звонок - последние 4 цифры номера являются кодом для авторизаии)"
        static let signInVCTextViewText    = "Нажимая кнопку «Далее», вы соглашаетесь с условиями Пользовательского соглашения и с обработкой вашей персональной информации на условиях Политики конфиденциальности."
        static let codeError               = "Введитете цифры от 0-9"
        static let numberError             = "Номер должен состоять только из цифр"
        static let senderButtonMainText    = "Отправить код еще раз"
    }
    
    enum Colors {
        static let mainColor = #colorLiteral(red: 0.2141760588, green: 0, blue: 0.7385079861, alpha: 1)
    }
    
    enum Images {
        static let closeBarItem = UIImage(systemName: "xmark")
        static let defaultImage = UIImage(named: "default")
    }
}





