package com.zz.util.shengyuan;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.Provider;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import javax.crypto.Cipher;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.util.Assert;

public final class RSAUtils {
    private static final Provider PROVIDER = new BouncyCastleProvider();
    private static final int KEY_SIZE = 1024;
    public static final String SIGN_ALGORITHMS = "SHA1WithRSA";

    private RSAUtils() {
    }

    public static KeyPair generateKeyPair() {
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA", PROVIDER);
            keyPairGenerator.initialize(1024, new SecureRandom());
            return keyPairGenerator.generateKeyPair();
        } catch (NoSuchAlgorithmException var1) {
            var1.printStackTrace();
            return null;
        }
    }

    public static byte[] encrypt(PublicKey publicKey, byte[] data) {
        Assert.notNull(publicKey);
        Assert.notNull(data);

        try {
            Cipher cipher = Cipher.getInstance("RSA", PROVIDER);
            cipher.init(1, publicKey);
            return cipher.doFinal(data);
        } catch (Exception var3) {
            var3.printStackTrace();
            return null;
        }
    }

    public static String encrypt(PublicKey publicKey, String text) {
        Assert.notNull(publicKey);
        Assert.notNull(text);
        byte[] data = encrypt(publicKey, text.getBytes());
        return data != null?AES64.encodeBase64String(data):null;
    }

    public static byte[] decrypt(PrivateKey privateKey, byte[] data) {
        Assert.notNull(privateKey);
        Assert.notNull(data);

        try {
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding", PROVIDER);
            cipher.init(2, privateKey);
            return cipher.doFinal(data);
        } catch (Exception var3) {
            return null;
        }
    }

    public static String decrypt(PrivateKey privateKey, String text) {
        Assert.notNull(privateKey);
        Assert.notNull(text);
        byte[] data = decrypt(privateKey, AES64.decodeBase64(text));
        return data != null?new String(data):null;
    }

    public static String sign(String content, String privateKey, String input_charset) {
        try {
            PKCS8EncodedKeySpec priPKCS8 = new PKCS8EncodedKeySpec(Base64.decode(privateKey));
            KeyFactory keyf = KeyFactory.getInstance("RSA");
            PrivateKey priKey = keyf.generatePrivate(priPKCS8);
            Signature signature = Signature.getInstance("SHA1WithRSA");
            signature.initSign(priKey);
            signature.update(content.getBytes(input_charset));
            byte[] signed = signature.sign();
            return Base64.encode(signed);
        } catch (Exception var8) {
            var8.printStackTrace();
            return null;
        }
    }

    public static boolean verify(String content, String sign, String ali_public_key, String input_charset) {
        try {
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            byte[] encodedKey = Base64.decode(ali_public_key);
            PublicKey pubKey = keyFactory.generatePublic(new X509EncodedKeySpec(encodedKey));
            Signature signature = Signature.getInstance("SHA1WithRSA");
            signature.initVerify(pubKey);
            signature.update(content.getBytes(input_charset));
            boolean bverify = signature.verify(Base64.decode(sign));
            return bverify;
        } catch (Exception var9) {
            var9.printStackTrace();
            return false;
        }
    }

    public static String decrypt(String content, String private_key, String input_charset) throws Exception {
        PrivateKey prikey = getPrivateKey(private_key);
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(2, prikey);
        InputStream ins = new ByteArrayInputStream(Base64.decode(content));
        ByteArrayOutputStream writer = new ByteArrayOutputStream();

        int bufl;
        byte[] block;
        for(byte[] buf = new byte[128]; (bufl = ins.read(buf)) != -1; writer.write(cipher.doFinal(block))) {
            byte[] block = null;
            if(buf.length == bufl) {
                block = buf;
            } else {
                block = new byte[bufl];

                for(int i = 0; i < bufl; ++i) {
                    block[i] = buf[i];
                }
            }
        }

        return new String(writer.toByteArray(), input_charset);
    }

    public static PrivateKey getPrivateKey(String key) throws Exception {
        byte[] keyBytes = Base64.decode(key);
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PrivateKey privateKey = keyFactory.generatePrivate(keySpec);
        return privateKey;
    }
}