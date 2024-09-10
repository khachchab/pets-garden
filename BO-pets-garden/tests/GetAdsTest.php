<?php
use PHPUnit\Framework\TestCase;

class GetAdsTest extends TestCase
{
    protected $db;
    protected $stmt;

    protected function setUp(): void
    {
        // Mock de la connexion à la base de données
        $this->db = $this->createMock(PDO::class);

        // Mock de la requête préparée
        $this->stmt = $this->createMock(PDOStatement::class);
    }

    public function testGetAdsReturnsData()
    {
        // Fake data that would come from the database
        $fakeAds = [
            [
                'id' => 1,
                'profile_name' => 'John Doe',
                'name' => 'Ad Name',
                'animal_type' => 'dog',
                'breed' => 'bulldog',
                'sex' => 'male',
                'age' => 2,
                'origin' => 'USA',
                'description' => 'A friendly dog',
                'start_date' => '2023-09-01',
                'end_date' => '2023-09-10',
                'city' => 'Paris',
                'comments' => 'No comments',
                'animal_photo' => 'photo.png'
            ]
        ];

        // Mock de l'exécution de la requête
        $this->stmt->expects($this->once())
                   ->method('execute')
                   ->willReturn(true);

        // Mock de la récupération des résultats
        $this->stmt->expects($this->once())
                   ->method('fetchAll')
                   ->willReturn($fakeAds);

        // Associer le mock de la requête préparée au mock de la base de données
        $this->db->expects($this->once())
                 ->method('prepare')
                 ->willReturn($this->stmt);

        // Capturer la sortie avec un buffer pour éviter les erreurs de headers
        ob_start();
        include './get_ads.php'; // Inclure ton fichier d'origine
        $output = ob_get_clean();

        // Vérifier que le résultat retourné est correct
        $this->assertJson($output);
        $data = json_decode($output, true);
        $this->assertCount(1, $data);
        $this->assertEquals('John Doe', $data[0]['profile_name']);
        $this->assertEquals('dog', $data[0]['animal_type']);
    }

    public function testGetAdsReturnsNoData()
    {
        // Mock de l'exécution de la requête
        $this->stmt->expects($this->once())
                   ->method('execute')
                   ->willReturn(true);

        // Mock de la récupération des résultats
        $this->stmt->expects($this->once())
                   ->method('fetchAll')
                   ->willReturn([]);

        // Associer le mock de la requête préparée au mock de la base de données
        $this->db->expects($this->once())
                 ->method('prepare')
                 ->willReturn($this->stmt);

        // Capturer la sortie avec un buffer pour éviter les erreurs de headers
        ob_start();
        include './get_ads.php'; // Inclure ton fichier d'origine
        $output = ob_get_clean();

        // Vérifier que le résultat retourné est correct
        $this->assertJson($output);
        $data = json_decode($output, true);
        $this->assertArrayHasKey('error', $data);
        $this->assertEquals('No ads found', $data['error']);
    }
}
