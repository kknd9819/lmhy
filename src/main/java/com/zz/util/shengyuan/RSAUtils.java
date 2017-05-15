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

import com.zz.util.shengyuan.aes.AES64;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.util.Assert;



/**
 * Utils - RSA加密解密
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public final class RSAUtils {

    /** 安全服务提供者 */
    private static final Provider PROVIDER = new BouncyCastleProvider();

    /** 密钥大小 */
    private static final int KEY_SIZE = 1024;

    public static final String SIGN_ALGORITHMS = "SHA1WithRSA";

    /**
     * 不可实例化
     */
    private RSAUtils() {
    }

    /**
     * 生成密钥对
     * @return 密钥对
     */
    public static KeyPair generateKeyPair() {
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA", PROVIDER);
            keyPairGenerator.initialize(KEY_SIZE, new SecureRandom());
            return keyPairGenerator.generateKeyPair();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 加密
     * @param publicKey 公钥
     * @param data 数据
     * @return 加密后的数据
     */
    public static byte[] encrypt(PublicKey publicKey, byte[] data) {
        Assert.notNull(publicKey);
        Assert.notNull(data);
        try {
            Cipher cipher = Cipher.getInstance("RSA", PROVIDER);
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            return cipher.doFinal(data);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 加密
     * @param publicKey 公钥
     * @param text 字符串
     * @return Base64编码字符串
     */
    public static String encrypt(PublicKey publicKey, String text) {
        Assert.notNull(publicKey,"公钥不能为NULL");
        Assert.notNull(text,"加密的数据不能为NULL");
        byte[] data = encrypt(publicKey, text.getBytes());
        return data != null ? AES64.encodeBase64String(data) : null;
    }

    /**
     * 解密
     * @param privateKey 私钥
     * @param data 数据
     * @return 解密后的数据
     */
    public static byte[] decrypt(PrivateKey privateKey, byte[] data) {
        Assert.notNull(privateKey);
        Assert.notNull(data);
        try {
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding", PROVIDER);
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            return cipher.doFinal(data);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 解密
     *
     * @param privateKey
     *            私钥
     * @param text
     *            Base64编码字符串
     * @return 解密后的数据
     */
    public static String decrypt(PrivateKey privateKey, String text) {
        Assert.notNull(privateKey);
        Assert.notNull(text);
        byte[] data = decrypt(privateKey, AES64.decodeBase64(text));
        return data != null ? new String(data) : null;
    }

    /**
     * RSA签名
     * @param content 待签名数据
     * @param privateKey 商户私钥
     * @param input_charset 编码格式
     * @return 签名值
     */
    public static String sign(String content, String privateKey, String input_charset)
    {
        try
        {
            PKCS8EncodedKeySpec priPKCS8 = new PKCS8EncodedKeySpec(Base64.decode(privateKey));
            KeyFactory keyf = KeyFactory.getInstance("RSA");
            PrivateKey priKey = keyf.generatePrivate(priPKCS8);
            Signature signature = java.security.Signature.getInstance(SIGN_ALGORITHMS);
            signature.initSign(priKey);
            signature.update(content.getBytes(input_charset));
            byte[] signed = signature.sign();
            return Base64.encode(signed);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * RSA验签名检查
     * @param content 待签名数据
     * @param sign 签名值
     * @param ali_public_key 支付宝公钥
     * @param input_charset 编码格式
     * @return 布尔值
     */
    public static boolean verify(String content, String sign, String ali_public_key, String input_charset)
    {
        try
        {
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            byte[] encodedKey = Base64.decode(ali_public_key);
            PublicKey pubKey = keyFactory.generatePublic(new X509EncodedKeySpec(encodedKey));
            Signature signature = java.security.Signature.getInstance(SIGN_ALGORITHMS);
            signature.initVerify(pubKey);
            signature.update(content.getBytes(input_charset));
            boolean bverify = signature.verify(Base64.decode(sign));
            return bverify;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 解密
     * @param content 密文
     * @param private_key 商户私钥
     * @param input_charset 编码格式
     * @return 解密后的字符串
     */
    public static String decrypt(String content, String private_key, String input_charset) throws Exception {
        PrivateKey prikey = getPrivateKey(private_key);
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, prikey);
        InputStream ins = new ByteArrayInputStream(Base64.decode(content));
        ByteArrayOutputStream writer = new ByteArrayOutputStream();
        //rsa解密的字节大小最多是128，将需要解密的内容，按128位拆开解密
        byte[] buf = new byte[128];
        int bufl;
        while ((bufl = ins.read(buf)) != -1) {
            byte[] block = null;
            if (buf.length == bufl) {
                block = buf;
            } else {
                block = new byte[bufl];
                for (int i = 0; i < bufl; i++) {
                    block[i] = buf[i];
                }
            }
            writer.write(cipher.doFinal(block));
        }
        return new String(writer.toByteArray(), input_charset);
    }

    /**
     * 得到私钥
     * @param key 密钥字符串（经过base64编码）
     * @throws Exception
     */
    public static PrivateKey getPrivateKey(String key) throws Exception {
        byte[] keyBytes;
        keyBytes = Base64.decode(key);
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PrivateKey privateKey = keyFactory.generatePrivate(keySpec);
        return privateKey;
    }

}