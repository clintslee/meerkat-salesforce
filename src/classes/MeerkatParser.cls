/**
 *  A JSON parser for parsing Meerkat API responses.
 *
**/
public with sharing class MeerkatParser 
{
	/**
	 *  @param jsonContent
	 *         a JSON string
	 *
	 *  @return a map representing the json object.
	 *
	 *  Parse the JSON response as a map.
	 *
	**/
	public static Map<String,Object> jsonToMap(String jsonContent)
	{
		return jsonToMap(JSON.createParser(jsonContent));
	}

	/**
	 *  @param jsonContent
	 *         a JSON string
	 *
	 *  @return a list representing the json object.
	 *
	 *  Parse the JSON response as a list.
	 *
	**/
	public static List<Object> jsonToList(String jsonContent)
	{
		return jsonToList(JSON.createParser(jsonContent));
	}

	/**
	 *  @param parser
	 *         a JSON Parser
	 *
	 *  @return a map of the parsed json
	 *
	**/
	private static Map<String,Object> jsonToMap(JSONParser parser)
	{
		Map<String,Object> m = new Map<String,Object>();

		if(parser.getCurrentToken() == null)
		   parser.nextToken();

		if(parser.getCurrentToken() != JSONToken.START_OBJECT)
		   throw new MeerkatParseException('A JSON object must start with a \'{\'');

		while(parser.nextToken() != null)
		{
			JSONToken currentToken = parser.getCurrentToken();

			if(currentToken == JSONToken.END_OBJECT) {
				break;
			} else if(currentToken == JSONToken.FIELD_NAME) {
				String fieldName = parser.getText();
				currentToken = parser.nextToken();

				if(currentToken == JSONToken.START_OBJECT) {
					m.put(fieldName,jsonToMap(parser));
				} else if(currentToken == JSONToken.START_ARRAY) {
					m.put(fieldName,jsonToList(parser));
				} else if(currentToken == JSONToken.VALUE_NULL) {
					m.put(fieldName,null);
				} else {
					m.put(fieldName,parser.getText());
				}
			} else {
				throw new MeerkatParseException('Unexpected JSON value: ' + parser.getText());
			}
		}
		return m;
	}

	/**
	 *  @param parser
	 *         a JSONParser
	 *
	 *  @return a list of the parsed json
	 *
	**/
	private static List<Object> jsonToList(JSONParser parser)
	{
		List<Object> jArray = new List<Object>();

		if(parser.getCurrentToken() == null) {
			parser.nextToken();
		}

		if(parser.getCurrentToken() != JSONToken.START_ARRAY) {
			throw new MeerkatParseException('A JSON array must start with a \'[\'');
		}

		while(parser.nextValue() != null)
		{
			JSONToken currentToken = parser.getCurrentToken();

			if(currentToken == JSONToken.END_ARRAY) {
				break;
			} else if(currentToken == JSONToken.START_ARRAY) {
				jArray.add(jsonToList(parser));
			} else if(currentToken == JSONToken.START_OBJECT) {
				jArray.add(jsonToMap(parser));
			} else {
                jArray.add(parser.getText());
			}
		}
		return jArray;
	}

	private class MeerkatParseException extends Exception {}
}