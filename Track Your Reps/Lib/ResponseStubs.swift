import Foundation


public func stubbedResponse(_ stub: ResponseStub) -> Data {
    return stub.rawValue.data(using: String.Encoding.utf8)!
}


public enum ResponseStub: String {
    
    case votesForMember = "{\"status\": \"OK\", \"copyright\": \"Pro Publica\", results: [{\"member_id\": \"1\", \"total_votes\": \"100\", \"offset\": \"0\", \"votes\": [{\"member_id\": \"1\", \"chamber\": \"Senate\", \"congress\": \"115\", \"session\": \"1\", \"roll_call\": \"1\", \"bill\": {\"number\": \"Res. 37\", \"bill_uri\": \"api.propublica.org/congress/v1/115/bills/hjres37\", \"title\": \"Hello title hello\", \"latest_action\": \"So much action\"}, \"member_id\": \"1\", \"description\": \"Something something something.\", \"question\": \"Is a question a question?\", \"date\": \"2017-03-02\", \"time\": \"0:00\", \"position\": \"Yes\"}]}]}"
    
    case membersForState = "{\"status\": \"OK\", \"copyright\": \"Pro Publica\", \"results\": {\"id\": \"1\", \"name\": \"Georgie George\", \"role\": \"Rep\", \"gender\": \"F\", \"party\": \"R\", \"times_topic_url\": \"\", \"twitter_id\": \"RepLeeZeldin\", \"youtube_id\": \"\", \"seniority\": \"4\", \"next_election\": \"2018\", \"https://api.propublica.org/congress/v1/members/Z000017.json\": \"\", \"district\": \"1\"}}"
}
