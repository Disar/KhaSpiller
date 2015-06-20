package spiller.system.store;

import spiller.SpiG;

/**
 * This class allows us to create a SQLite database and work with it.
 * Can be used in Desktop and Android but not in HTML5.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / Ratalaika Games
 */
class SpiSave
{
	// /**
	//  * SQLite DATABASE.
	//  */
	// private final String _database;
	// /**
	//  * Our SQLite _stmtement.
	//  */
	// private Statement _stmt;
	// /**
	//  * Our SQLite connection
	//  */
	// private Connection _conection;
	// /**
	//  * Shows if the database is ready.
	//  */
	// private boolean _ready;

	// /**
	//  * Class constructor.
	//  * 
	//  * @param database		The database path.
	//  */
	// public SpiSave(String database)
	// {
	// 	_database = database;
	// 	_ready = false;
	// }

	// /**
	//  * Returns if the database is ready or not.
	//  */
	// public boolean isReady()
	// {
	// 	return _ready;
	// }

	// /**
	//  * Open the database.
	//  */
	// public void open()
	// {
	// 	// Initialize the connection driver
	// 	try {
	// 		if(SpiG.mobile) {
	// 			Class.forName("org.sqldroid.SQLDroidDriver");
	// 		} else
	// 			Class.forName("org.sqlite.JDBC");
	// 	} catch (ClassNotFoundException e) { e.printStackTrace(); }
		
	// 	// Set up mobile device things
	// 	if(SpiG.mobile) {
	// 		try {
	// 			DriverManager.registerDriver((Driver)(Class.forName("org.sqldroid.SQLDroidDriver", true, getClass().getClassLoader()).newInstance()));
	// 		} catch(Exception e) { e.printStackTrace(); }
	// 	}

	// 	// Establish the connection with the database
	// 	try {
	// 		_conection = DriverManager.getConnection("jdbc:sqlite:"+_database);
	// 	} catch (SQLException e) { e.printStackTrace(); }

	// 	// Create the _stmtement
	// 	try {
	// 		_stmt = _conection.createStatement();
	// 	} catch (SQLException e) { e.printStackTrace(); }
		
	// 	_ready = true;
	// }

	// /**
	//  * Write values via raw SQL statement.
	//  * (Update, Delete, Insert).
	//  * 
	//  * @param 	sql		A complete SQL statement.
	//  * @return	Whether or not the write were successful.
	//  */
	// public boolean query(String sql)
	// {
	// 	if(!_ready)
	// 		return false;

	// 	boolean correct = true;
	// 	try {
	// 		String[] querys = sql.split(";");
	// 		for(String query : querys) {
	// 			_stmt.execute(query);
	// 		}
	// 	} catch (SQLException e) { e.printStackTrace(); correct = false; }
	// 	return correct;
	// }

	// /**
	//  * Select values via raw SQL statement.
	//  * 
	//  * @param sql
	//  * @return
	//  */
	// public ResultSet select(String sql)
	// {
	// 	if(!_ready)
	// 		return null;

	// 	ResultSet result = null;
	// 	try {
	// 		result = _stmt.executeQuery(sql);
	// 	} catch (SQLException e) { e.printStackTrace(); }

	// 	return result;
	// }

	// /**
	//  * Close the database.
	//  */
	// public void close()
	// {
	// 	if(!_ready)
	// 		return;

	// 	try {
	// 		_stmt.close();
	// 		_conection.close();
	// 	} catch (SQLException e) { e.printStackTrace(); }
		
	// 	_ready = false;
	// }
}

