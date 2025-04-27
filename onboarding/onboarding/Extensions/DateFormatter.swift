//
//  DateFormatter.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import Foundation

// 날짜와 시간을 "yyyy.MM.dd (E) HH:mm:ss" 형식으로 변환해주는 포맷터
extension DateFormatter {
    static let kickboardFormatWithTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd (E) HH:mm:ss"
        return formatter
    }()
}

/*
 사용 예시
 let todayString = DateFormatter.kickboardFormatWithTime.string(from: Date())
 → "2025.04.28 (Mon) 15:32:45" 이런 식으로 날짜와 시간을 문자열로 만들어줌
 시간을 지우고 싶을 경우, dateFormat 설정에서 HH:mm:ss 부분만 삭제.

 */

/*
 이 파일은 날짜(Date)를 사람이 읽기 좋은 문자열(String)로 변환하는 포맷터를 만들어둔 파일입니다.
 등록 날짜나 반납 날짜처럼 날짜+시간을 표시할 때 사용합니다.
 "yyyy.MM.dd (E) HH:mm:ss" 형식으로 변환해줍니다.
 HistoryViewController나 RegistrationViewController 같은 내역 화면에서 활용할 예정입니다.
 */
