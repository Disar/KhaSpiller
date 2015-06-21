package spiller.system;

import kha.Loader;
import kha.Storage;
import kha.Image;
import kha.Sound;
import kha.Music;
import kha.Blob;
import kha.StorageFile;
import kha.Video;

import spiller.SpiG;
import spiller.system.SpiAssetManager.AssetType;
import spiller.util.tmx.TiledMap;
import spiller.system.kha.graphics.atlas.AtlasRegion;
import spiller.system.kha.graphics.atlas.TextureAtlas;

/**
 * This class provides an easy way to load and store textures, fonts, sounds and music.
 * 
 * v1.1 Added more public methods<br>
 * v1.0 Initial version (?)
 * 
 * @version 1.1 - 23/03/2013
 * @author ratalaika / Ratalaika Games
 * @author Thomas Weston
 */
 @:access(kha.Loader)
class SpiAssetManager
{
	/**
	 * The asset manager instance.
	 */
	private var _assetManager:Loader;
	/**
	 * The assets map.
	 */
	private var _groups:Map<String, Array<Asset>>;
	/**
	 * The runtime textures.
	 */
	private var _runtimeTextures:Map<String, AtlasRegion>;
	/**
	 * The atlas maps.
	 */
	private var _textureAtlases:Map<String, TextureAtlas>;
	
	/**
	 * Return the manager instance.
	 */
	public static function getInstance():SpiAssetManager
	{		
		return SpiG._cache;
	}

	/**
	 * Class constructor.
	 */
	public function new()
	{
		_assetManager = Loader.the;
		_runtimeTextures = new Map<String, AtlasRegion>();
		_textureAtlases = new Map<String, TextureAtlas>();
	}

	/**
	 * Loads an asset from a file.
	 * 
	 * @param FileName The path to the asset file.
	 * @param Type The type of asset.
	 * @param Parameter Optional parameters for the loader.
	 * 
	 * @return The asset, if found.
	 */
	public function get(fileName:String, type:AssetType):Dynamic
	{
		if(!containsAsset(fileName, type)) {
			throw "Asset " + fileName + " not loaded!";
		}

		switch(type) {
			case IMAGE:
				return getImage(fileName);
			case MUSIC:
				return getMusic(fileName);
			case SOUND:
				return getSound(fileName);
			case VIDEO:
				return getVideo(fileName);
			case BLOB:
				return getBlob(fileName);
			case SHADER:
				return getShader(fileName);
			case ATLAS:
				return getAtlas(fileName);
			case ANY:
				return null;
		}

		return null;
	}

	/**
	 * Generate a new atlas from an image and a text, LibGDX style.
	 * The atlas image & text MUST be loaded before call this.
	 * This method only set up memory atlas representation not loads anything.
	 */
	public function loadAtlas(fileText:String, graphicImage:String, atlasId:String):Void
	{
		var textureAtlas = new TextureAtlas();
		textureAtlas.loadAtlas(fileText, graphicImage);
		_textureAtlases.set(atlasId, textureAtlas);
	}

	/**
	 * Disposes the asset and removes it from the manager.
	 * 
	 * @param FileName The asset to dispose.
	 */
	public function unload(FileName:String, Type:AssetType):Void
	{
		switch(Type) {
			case IMAGE:
				_assetManager.removeImage(_assetManager.images, FileName);
			case MUSIC:
				_assetManager.removeMusic(_assetManager.musics, FileName);
			case SOUND:
				_assetManager.removeSound(_assetManager.sounds, FileName);
			case VIDEO:
				_assetManager.removeVideo(_assetManager.videos, FileName);
			case BLOB:
				_assetManager.removeBlob(_assetManager.blobs, FileName);
			case SHADER:
			case ANY:
			case ATLAS:
				_textureAtlases.remove(FileName);
				_assetManager.removeImage(_assetManager.images, FileName);

		}
	}

	/**
	 * Whether or not the cache contains an asset with this key.
	 * 
	 * @param Key The key to check.
	 * @param Type The type of asset.
	 * 
	 * @return Whether or not the key exists.
	 */
	public function containsAsset(FileName:String, Type:AssetType):Bool
	{
		switch(Type) {
			case IMAGE:
				return _assetManager.isImageAvailable(FileName);
			case MUSIC:
				return _assetManager.isMusicAvailable(FileName);
			case SOUND:
				return _assetManager.isSoundAvailable(FileName);
			case VIDEO:
				return _assetManager.isVideoAvailable(FileName);
			case BLOB:
				return _assetManager.isBlobAvailable(FileName);
			case SHADER:
				//TODO return _assetManager.isShaderAvailable(FileName);
			case ATLAS:
				return _textureAtlases.exists(FileName);
			case ANY:
				return _textureAtlases.exists(FileName)         ||
					   _runtimeTextures.exists(FileName)        ||
					   _assetManager.isImageAvailable(FileName) || 
					   _assetManager.isSoundAvailable(FileName) ||
					   _assetManager.isMusicAvailable(FileName) ||
					   _assetManager.isBlobAvailable(FileName)  ||
					   _assetManager.isVideoAvailable(FileName);
		}

		return false;
	}

	/**
	 * Disposes all textures that were created at run time i.e. not loaded from
	 * an external file.
	 */
	public function disposeRunTimeTextures():Void
	{
		for (textureKey in _runtimeTextures.keys()) {
			var texture:AtlasRegion = _runtimeTextures.get(textureKey);
			_runtimeTextures.remove(textureKey);
			_textureAtlases.remove(textureKey);
			texture.getTexture().unload();
		}
	}

	/**
	 * Disposes all textures that were created at run time i.e. not loaded from
	 * an external file.
	 */
	public function addRuntimeTexture(key:String, image:Image):Void
	{
		if(_runtimeTextures.exists(key))
			return;

		var atlas:AtlasRegion = new AtlasRegion(image, key);
		_runtimeTextures.set(key, atlas);
	}

	/**
	 * Disposes all assets of a certain type.
	 */
	public function disposeAssets(Type:AssetType):Void
	{
		switch(Type) {
			case SHADER:
			case ANY:
			case IMAGE:
				for (imagename in _assetManager.images.keys()) {
					if (!Loader.containsAsset(imagename, "image", _assetManager.enqueued))
						_assetManager.removeImage(_assetManager.images, imagename);
				}
				for (textureKey in _runtimeTextures.keys()) {
					var texture:AtlasRegion = _runtimeTextures.get(textureKey);
					_runtimeTextures.remove(textureKey);
					_textureAtlases.remove(textureKey);
					texture.getTexture().unload();
				}
			case MUSIC:
				for (musicname in _assetManager.musics.keys()) { 
					if (!Loader.containsAsset(musicname, "music", _assetManager.enqueued))
						_assetManager.removeMusic(_assetManager.musics, musicname);
				}
			case SOUND:
				for (soundname in _assetManager.sounds.keys()) {
					if (!Loader.containsAsset(soundname, "sound", _assetManager.enqueued))
						_assetManager.removeSound(_assetManager.sounds, soundname);
				}
			case VIDEO:
				for (videoname in _assetManager.videos.keys()) {
					if (!Loader.containsAsset(videoname, "video", _assetManager.enqueued))
						_assetManager.removeVideo(_assetManager.videos, videoname);
				}
			case BLOB:
				for (blobname  in _assetManager.blobs.keys()) {
					if (!Loader.containsAsset(blobname,  "blob",  _assetManager.enqueued))
						_assetManager.removeBlob(_assetManager.blobs, blobname);
				}
			case ATLAS:
				for (atlasKey in _textureAtlases.keys()) {
					if (!Loader.containsAsset(atlasKey, "image", _assetManager.enqueued))
						_assetManager.removeImage(_assetManager.images, atlasKey);
					_textureAtlases.remove(atlasKey);
				}
		}
	}

	/**
	 * Disposes the cache.
	 */
	public function dispose():Void
	{
		_assetManager.cleanup();
	}

	/**
	 * Clears and disposes all assets currently contained in the cache.
	 */
	public function clear():Void
	{
		_assetManager.cleanup();
	}

	/**
	 * The number of assets contained in the manager. Useful for debugging.
	 * 
	 * @return The number of assets.
	 */
	public function getNumberOfAssets():Int
	{
		return _assetManager.loadcount;
	}

	// /**
	//  * Gets the names of all the assets contained in the manager. Useful for
	//  * debugging.
	//  * 
	//  * @return The names of all assets.
	//  */
	// public Array<String> getNamesOfAssets()
	// {
	// 	return _assetManager.getAssetNames();
	// }

	// /**
	//  * Load a group of assets.
	//  * 
	//  * @param groupName The group name.
	//  */
	// public void loadGroup(String groupName)
	// {
	// 	Array<Asset> assets = _groups.get(groupName, null);

	// 	if (assets != null) {
	// 		for (Asset asset : assets) {
	// 			_assetManager.load(asset.path, asset.type);
	// 		}
	// 	} else {
	// 		SpiG.log("Error loading group " + groupName + ", not found");
	// 	}
	// }

	// /**
	//  * Load all group of assets.
	//  * 
	//  * @param groupName The group name.
	//  */
	// public void loadGroups()
	// {
	// 	Keys<String> keys = _groups.keys();
	// 	while (keys.hasNext) {
	// 		loadGroup(keys.next());
	// 	}
	// }

	// /**
	//  * Unload a group of assets.
	//  * 
	//  * @param groupName The group name
	//  */
	// public void unloadGroup(String groupName)
	// {
	// 	Array<Asset> assets = _groups.get(groupName, null);

	// 	if (assets != null) {
	// 		for (Asset asset : assets) {
	// 			if (_assetManager.isLoaded(asset.path, asset.type)) {
	// 				_assetManager.unload(asset.path);
	// 			}
	// 		}
	// 	} else {
	// 		SpiG.log("Error unloading group " + groupName + ", not found");
	// 	}
	// }

	/**
	 * Get an image according to its file name.
	 * 
	 * @param fileName The file name.
	 * @return The asset.
	 */
	public function getImage(fileName:String):Image
	{
		return _assetManager.getImage(fileName);
	}

	/**
	 * Get an sound according to its file name.
	 * 
	 * @param fileName The file name.
	 * @return The asset.
	 */
	public function getSound(fileName:String):Sound
	{
		return _assetManager.getSound(fileName);
	}

	/**
	 * Get an music according to its file name.
	 * 
	 * @param fileName The file name.
	 * @return The asset.
	 */
	public function getMusic(fileName:String):Music
	{
		return _assetManager.getMusic(fileName);
	}

	/**
	 * Get an video according to its file name.
	 * 
	 * @param fileName The file name.
	 * @return The asset.
	 */
	public function getVideo(fileName:String):Video
	{
		return _assetManager.getVideo(fileName);
	}

	/**
	 * Get an blob according to its file name.
	 * 
	 * @param fileName The file name.
	 * @return The asset.
	 */
	public function getBlob(fileName:String):Blob
	{
		return _assetManager.getBlob(fileName);
	}

	/**
	 * Get a shader according to its file name.
	 * 
	 * @param fileName The file name.
	 * @return The asset.
	 */
	public function getShader(fileName:String):Blob
	{
		return _assetManager.getShader(fileName);
	}

	/**
	 * Get an atlas according to its file name.
	 * 
	 * @param fileName The file name.
	 * @return The asset.
	 */
	public function getAtlas(fileName:String):Dynamic
	{
		if(_runtimeTextures.exists(fileName))
			return _runtimeTextures.get(fileName);
		else
			return _textureAtlases.get(fileName);
	}

	/**
	 * Get progress in percent of completion.
	 * 
	 * @return The progress in percent of completion.
	 */
	public function getProgress():Float
	{
		return _assetManager.getLoadPercentage();
	}
	
	// /**
	//  * Load all groups of assets.
	//  * 
	//  * @param assetFile The XML with the groups of assets.
	//  */
	// public void queueGroups(String assetFile)
	// {
	// 	_groups = new ObjectMap<String, Array<Asset>>();
	// 	FileHandleResolver resolver = new SpiFileHandleResolver();

	// 	// Parse the XML to obtain all assets.
	// 	try {
	// 		XmlReader reader = new XmlReader(); // Start the XML Reader
	// 		Element root = reader.parse(resolver.resolve(assetFile)); // Parse our XML file
	// 		Array<Element> groupElements = root.getChildrenByName("group"); // Get all the groups

	// 		// Loop through the groups loading all the elements
	// 		for (int i = 0; i < groupElements.size; i++) {
	// 			Element groupElement = groupElements.get(i);
	// 			String groupName = groupElement.getAttribute("name", "base"); // Get the name attribute from the group

	// 			// Check if the group contains the group name.
	// 			if (_groups.containsKey(groupName)) {
	// 				SpiG.log("The group " + groupName + " already exists, skipping");
	// 				continue;
	// 			}

	// 			Array<Asset> assets = new Array<Asset>();
	// 			Array<Element> assetElements = groupElement.getChildrenByName("asset"); // Get all the asset

	// 			// Loop through the groups loading all the assets
	// 			for (int j = 0; j < assetElements.size; j++) {
	// 				Element assetElement = assetElements.get(j);
	// 				assets.add(new Asset(assetElement.getAttribute("type", ""), assetElement.getAttribute("path", "")));
	// 			}

	// 			_groups.put(groupName, assets);
	// 		}
	// 	} catch (Exception e) {
	// 		SpiG.log("Error loading file " + assetFile + " " + e.getMessage());
	// 	}
	// }

	/**
	 * Return a new file handle.
	 * 
	 * @param fileName The file name route.
	 * @return The file handle.
	 */
	public static function getFileHandle(fileName:String):StorageFile
	{
		//if (fileName.startsWith("com/ratalaika/spiller"))
		//	return Gdx.files.classpath(fileName);
		//else
		//	return Gdx.files.internal(fileName);
		return Storage.namedFile(fileName);
	}
}

/**
 * Internal class representing an asset.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 07/06/2013
 * @author ratalaika / Ratalaika Games
 */
class Asset
{
	/**
	 * The asset type.
	 */
	public var type:String;
	/**
	 * The asset path.
	 */
	public var path:String;

	/**
	 * Class constructor.
	 * 
	 * @param type The asset type.
	 * @param path The asset path.
	 */
	public function new(type:String, path:String)
	{
		this.type = type;
		this.path = path;
	}
}

/**
 * All the asset types.
 */
enum AssetType
{
	ANY;
	IMAGE;
	SOUND;
	MUSIC;
	VIDEO;
	BLOB;
	SHADER;
	ATLAS;
}