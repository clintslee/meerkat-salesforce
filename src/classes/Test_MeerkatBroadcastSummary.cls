@istest
public with sharing class Test_MeerkatBroadcastSummary 
{
	private static String response = '{\"result\":{\"id\":\"1234\",' + 
                                     '\"cover\":\"https://static.meerkatapp.co\",' + 
                                     '\"broadcaster\":{\"id\":\"5678\"},' +
                                     '\"caption\":\"test\",' +
                                     '\"location\":\"Atlanta\",' +
                                     '\"place\":\"Atlanta\",' +
                                     '\"watchersCount\":10,' + 
                                     '\"commentsCount\":20,' + 
                                     '\"likesCount\":30,' +
                                     '\"restreamsCount\":5,' +
                                     '\"activities\":[],' + 
                                     '\"influencers\":[\"b:12345\"],' +
                                     '\"status\":\"live\",' +
                                     '\"endTime\":1431424250723,' +
                                     '\"tags\":[\"testing\"],' +
                                     '\"tweetId\":\"9090\"' +
	                               '}}';


	static testmethod void testOne()
	{
          setupData();

          Test.startTest();
          MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',response,null);
          Test.setMock(HttpCalloutMock.class,mock);

          MeerkatRestClient client = MeerkatAPI.getDefaultClient();
          MeerkatBroadcastSummary bcs = client.getBroadcast('123').getSummary();

          System.assert(bcs.getResourceLocation().contains('123'));
          System.assertEquals('result',bcs.getResultKey());
          System.assertEquals('1234',bcs.getId());
          System.assertEquals('https://static.meerkatapp.co',bcs.getCover());
          System.assertEquals('5678',(String)bcs.getBroadcaster().get('id'));
          System.assertEquals('test',bcs.getCaption());
          System.assertEquals('Atlanta',bcs.getLocation());
          System.assertEquals('Atlanta',bcs.getPlace());
          System.assertEquals(10,bcs.getWatchersCount());
          System.assertEquals(20,bcs.getCommentsCount());
          System.assertEquals(30,bcs.getLikesCount());
          System.assertEquals(5,bcs.getRestreamsCount());
          System.assertEquals('live',bcs.getStatus());
          System.assertEquals(DateTime.newInstance(Long.valueOf('1431424250723')),bcs.getEndTime());
          System.assertEquals('9090',bcs.getTweetId());
          System.assertEquals('testing',bcs.getTags().get(0));
          System.assertEquals('b:12345',bcs.getInfluencers().get(0));
          Test.stopTest();
	}

      static testmethod void setupData()
      {
            MeerkatConfig__c config = MeerkatConfig__c.getOrgDefaults();
            config.API_Key__c = '112358';
            upsert config;
      }
}