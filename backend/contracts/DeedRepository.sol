pragma solidity ^0.5.16;
// ERC721(ノンファンジルトークンのコントラクトを読み込む)
import "./ERC721/ERC721Token.sol";

/**
 * @title ERC721トークン(証書)のリポジトリコントラクト
 * ユーザーが登録したトークン(証書)のリストを含む。
 */
contract DeedRepository is ERC721Token {

    /**
    * トークンが登録された時のイベント
    * @param _by 登録者のアドレス
    * @param _tokenId トークンID
    */
    event DeedRegistered(address _by, uint256 _tokenId);

    /**
    * コンストラクター
    * @param _name リポジトリの名前
    * @param _symbol リポジトリのシンボル
    */
    constructor(string memory _name, string memory _symbol) {
        public ERC721Token(_name, _symbol) {}
    }
    
    /**
    * 新しいトークン(証書)を登録する関数
    * @dev ERC721トークン作成者が呼び出す
    * @param _tokenId 特定のトークン(証書)を表すID
    * @param _uri メタデータ/URI情報
    */
    function registerDeed(uint256 _tokenId, string memory _uri) public {
        // トークン登録
        _mint(msg.sender, _tokenId);
        // メタデータ追加
        addDeedMetadata(_tokenId, _uri);
        // イベントの呼び出し
        emit DeedRegistered(msg.sender, _tokenId);
    }

    /**
    * メタデータをトークン(証書)に追加するための関数
    * @param _tokenId トークンID
    * @param _uri トークンの特徴を記述するテキスト
    * @return whether トークンのメタデータがリポジトリに追加されたかどうかを示す。
    */
    function addDeedMetadata(uint256 _tokenId, string memory _uri) public returns(bool){
        // メタデータをセット
        _setTokenURI(_tokenId, _uri);
        // 戻り値を返す。
        return true;
    }
}
