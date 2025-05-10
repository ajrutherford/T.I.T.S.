-- Species table (shared by assassins and targets)

CREATE DATABASE IF NOT EXISTS Assassinations_DB;
USE Assassinations_DB;

DROP TABLE IF EXISTS contracts, reasons_for_termination,targets, assassins,species;


-- Species table
CREATE TABLE species (
    species_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    home_planet VARCHAR(100),
    danger_level TINYINT CHECK (danger_level BETWEEN 1 AND 10),
    description TEXT
);

-- Assassins table
CREATE TABLE assassins (
    assassin_id INT AUTO_INCREMENT PRIMARY KEY,
    code_name VARCHAR(100) UNIQUE NOT NULL,
    real_name VARCHAR(100),
    species_id INT,
    years_active INT,
    reputation_score DECIMAL(3,1) CHECK (reputation_score BETWEEN 0 AND 10),
    preferred_weapon VARCHAR(100),
    FOREIGN KEY (species_id) REFERENCES species(species_id)
);

-- Targets table
CREATE TABLE targets (
    target_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    alias VARCHAR(100),
    species_id INT,
    last_known_location VARCHAR(200),
    threat_level TINYINT CHECK (threat_level BETWEEN 1 AND 10),
    FOREIGN KEY (species_id) REFERENCES species(species_id)
);

-- Reasons for Termination table
CREATE TABLE reasons_for_termination (
    reason_id INT AUTO_INCREMENT PRIMARY KEY,
    reason_text VARCHAR(100) NOT NULL
);

-- Contracts table
CREATE TABLE contracts (
    contract_id INT AUTO_INCREMENT PRIMARY KEY,
    assassin_id INT,
    target_id INT,
    reason_id INT,
    reward_amount DECIMAL(15,2),
    currency VARCHAR(20) DEFAULT 'Galactic Credits',
    is_completed BOOLEAN DEFAULT FALSE,
    contract_date DATE DEFAULT (CURRENT_DATE),
    completion_date DATE,
    FOREIGN KEY (assassin_id) REFERENCES assassins(assassin_id),
    FOREIGN KEY (target_id) REFERENCES targets(target_id),
    FOREIGN KEY (reason_id) REFERENCES reasons_for_termination(reason_id)
);

INSERT INTO species (name, home_planet, danger_level, description) VALUES
('Zarglon', 'Nebulon-5', 9, 'Cold-blooded reptilian hunters with psychic tracking abilities.'),
('Velari', 'Xenthros Prime', 4, 'Peaceful, photosynthetic beings known for diplomacy.'),
('Mechari', 'Forge World KX-22', 7, 'Cybernetic constructs designed for war.'),
('Umbrixian', 'Void Sector 12', 10, 'Shadow-dwelling entities made of dark matter.'),
('Terran', 'Earth', 3, 'Standard human species from the Sol system.'),
('Voltarian', 'Voltar', 3, 'The most chilled species in the universe');

INSERT INTO assassins (code_name, real_name, species_id, years_active, reputation_score, preferred_weapon) VALUES
('VoidFang', 'Kara Zenth', 4, 17, 9.5, 'Quantum Blade'),
('Iron Whisper', 'Unit 44-B', 3, 12, 8.8, 'Silenced Plasmacaster'),
('Stellar Wraith', 'Drayven Voss', 1, 22, 9.9, 'Phase Dagger'),
('GhostBloom', 'Lira Sen', 2, 5, 6.7, 'Neural Spore Bomb'),
('DeadEye Jack', 'Jack Monroe', 5, 10, 7.3, 'Sniper Pulse Rifle');

INSERT INTO targets (name, alias, species_id, last_known_location, threat_level) VALUES
('Xerax the Unyielding', 'The Devourer of Suns', 1, 'Crimson Nebula', 10),
('Ambassador Eluvi', 'The Silver Tongue', 2, 'Unity Station Delta', 3),
('High Inquisitor Mek-Torr', 'The Steel Judge', 3, 'Orbit of Torvak-9', 8),
('Captain Leona Vega', 'Solar Siren', 5, 'Deep Core Colony Z-19', 6),
('Umbrix Shard 7B', 'Echo of the Void', 4, 'Uncharted Rift Sector', 10);

INSERT INTO reasons_for_termination (reason_text) VALUES
('Treason against the Galactic Coalition'),
('Unlawful use of forbidden technology'),
('Contracted by rival syndicate'),
('Information leak risk'),
('Elimination of political opposition'),
('Chewing gum in the turbolift');

INSERT INTO contracts (assassin_id, target_id, reason_id, reward_amount, is_completed, contract_date, completion_date) VALUES
(1, 1, 2, 750000.00, TRUE, '2425-03-21', '2425-03-27'),
(2, 3, 1, 400000.00, TRUE, '2425-04-10', '2425-04-14'),
(3, 5, 4, 1200000.00, FALSE, '2425-05-01', NULL),
(4, 2, 5, 150000.00, TRUE, '2425-02-11', '2425-02-13'),
(5, 4, 3, 275000.00, FALSE, '2425-04-28', NULL);