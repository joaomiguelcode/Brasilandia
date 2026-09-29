const fs = require('fs');
const path = require('path');

// Vehicle Image Saver Module
class VehicleImageSaver {
    constructor() {
        this.imagesDir = path.join(__dirname, '..', 'web-side', 'images');
        this.webhookURL = "https://discordapp.com/api/webhooks/1486379268970647683/sPvWeewq_M0piwYCo8aZaG8T6I_1mFdII5sNWgeBv9ecEoN8WdHCLWrpbDcT_lGmy7Iv";
        
        // Ensure images directory exists
        this.ensureDirectory();
    }

    ensureDirectory() {
        if (!fs.existsSync(this.imagesDir)) {
            fs.mkdirSync(this.imagesDir, { recursive: true });
            console.log('[PDM-Saver] Images directory created:', this.imagesDir);
        }
    }

    saveVehicleImage(vehicleName, imageData) {
        try {
            const fileName = `${vehicleName}.jpg`;
            const filePath = path.join(this.imagesDir, fileName);
            
            // Write base64 data to file
            const base64Data = imageData.replace(/^data:image\/jpeg;base64,/, '');
            fs.writeFileSync(filePath, base64Data, 'base64');
            
            console.log(`[PDM-Saver] Image saved: ${fileName}`);
            
            // Send notification to Discord
            this.sendDiscordNotification(vehicleName, fileName);
            
            return true;
        } catch (error) {
            console.error(`[PDM-Saver] Error saving image for ${vehicleName}:`, error);
            return false;
        }
    }

    sendDiscordNotification(vehicleName, fileName) {
        const embed = {
            embeds: [{
                title: `Nova Imagem de Veículo - ${vehicleName}`,
                description: `Imagem capturada automaticamente pelo sistema PDM\n\n**Arquivo:** ${fileName}`,
                color: 3447003,
                timestamp: new Date().toISOString()
            }]
        };

        const postData = JSON.stringify(embed);
        
        // Using Node.js HTTP module for Discord webhook
        const https = require('https');
        const url = require('url');
        const parsedUrl = url.parse(this.webhookURL);
        
        const options = {
            hostname: parsedUrl.hostname,
            port: parsedUrl.port || 443,
            path: parsedUrl.path,
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Content-Length': Buffer.byteLength(postData)
            }
        };

        const req = https.request(options, (res) => {
            if (res.statusCode === 204) {
                console.log(`[PDM-Saver] Discord notification sent for ${vehicleName}`);
            } else {
                console.log(`[PDM-Saver] Discord webhook response: ${res.statusCode}`);
            }
        });

        req.on('error', (error) => {
            console.error(`[PDM-Saver] Discord webhook error:`, error);
        });

        req.write(postData);
        req.end();
    }

    deleteVehicleImage(vehicleName) {
        try {
            const fileName = `${vehicleName}.jpg`;
            const filePath = path.join(this.imagesDir, fileName);
            
            if (fs.existsSync(filePath)) {
                fs.unlinkSync(filePath);
                console.log(`[PDM-Saver] Image deleted: ${fileName}`);
                return true;
            }
        } catch (error) {
            console.error(`[PDM-Saver] Error deleting image for ${vehicleName}:`, error);
        }
        return false;
    }

    listVehicleImages() {
        try {
            const files = fs.readdirSync(this.imagesDir);
            return files.filter(file => file.endsWith('.jpg')).map(file => file.replace('.jpg', ''));
        } catch (error) {
            console.error('[PDM-Saver] Error listing images:', error);
            return [];
        }
    }
}

// Export for use in other modules
module.exports = VehicleImageSaver;

// Auto-initialize when module loads
const saver = new VehicleImageSaver();
console.log('[PDM-Saver] Vehicle Image Saver initialized');
