<?php
use PHPUnit\Framework\TestCase;

require_once './db.php'; // Ajuste le chemin si nécessaire

class DatabaseTest extends TestCase
{
    protected $db;

    // Setup exécuté avant chaque test
    protected function setUp(): void
    {
        $this->db = new Database();
    }

    public function testConnection()
    {
        $connection = $this->db->getConnection();
        $this->assertInstanceOf(PDO::class, $connection, 'La connexion doit retourner une instance de PDO.');
    }

    public function testConnectionFailure()
    {
        $this->db = new Database('wrong_host', 'wrong_db', 'wrong_user', 'wrong_pass');
        $this->expectException(PDOException::class);
        $this->db->getConnection();
    }
}
