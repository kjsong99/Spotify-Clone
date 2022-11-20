package com.song.spotifyback.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import javax.persistence.*;

@Entity
public class MusicFeatures {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JsonIgnore
    private Long id;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "music_id")
    private Music music;

    @ManyToOne
    @JsonSerialize(contentAs = Artist.class)
    @JoinColumn(name = "artist_id")
    private Artist artist;

}
